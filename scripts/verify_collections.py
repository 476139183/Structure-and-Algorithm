#!/usr/bin/env python3
"""Verify archived sources against the recorded Git blob hashes and history tags."""
import hashlib,json,os,pathlib,subprocess,sys
ROOT=pathlib.Path(__file__).resolve().parents[1]
manifest=json.loads((ROOT/'catalog/manifest.json').read_text())
errors=[];total=0
for source in manifest['sources']:
 base=ROOT/source['destination'];expected=set()
 for f in source['tracked_files']:
  path=base/f['path'];expected.add(f['path'])
  try:
   data=os.readlink(path).encode() if path.is_symlink() else path.read_bytes()
   digest=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
   if digest!=f['imported_blob']:errors.append('Content differs: '+str(path.relative_to(ROOT)))
   mode='120000' if path.is_symlink() else ('100755' if path.stat().st_mode&0o111 else '100644')
   if mode!=f['mode']:errors.append('Mode differs: '+str(path.relative_to(ROOT)))
  except OSError as e:errors.append(str(path.relative_to(ROOT))+': '+str(e))
  total+=1
 actual={p.relative_to(base).as_posix() for p in base.rglob('*') if p.is_file() or p.is_symlink()}
 if actual!=expected:errors.append(source['name']+': file list differs: '+repr(sorted(actual.symmetric_difference(expected))[:10]))
 for ref,sha in source['history_tags'].items():
  p=subprocess.run(['git','-C',str(ROOT),'rev-parse',ref],capture_output=True,text=True)
  if p.returncode or p.stdout.strip()!=sha:errors.append('History tag differs/missing: '+ref+' (fetch tags if this is a shallow clone)')
 if not (ROOT/'catalog'/(source['name']+'.md')).is_file():errors.append('Missing source page: '+source['name'])
if errors:
 print('\n'.join(errors[:40]),file=sys.stderr);sys.exit(1)
print('Verified '+str(len(manifest['sources']))+' source snapshots and '+str(total)+' files; all recorded history tags match.')
