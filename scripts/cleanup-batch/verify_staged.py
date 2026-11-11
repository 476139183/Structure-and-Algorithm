"""Ensure Git staging preserved the exact imported bytes and original target files."""
import json,pathlib,subprocess
root=pathlib.Path(__file__).resolve().parents[2]
manifest=json.loads((root/'catalog/manifest.json').read_text())
raw=subprocess.check_output(['git','-C',str(root),'ls-files','--stage','-z'])
staged={}
for entry in raw.split(b'\0'):
 if not entry:continue
 meta,path=entry.split(b'\t',1);mode,sha,stage=meta.decode().split()
 staged[path.decode()]=(mode,sha)
for source in manifest['sources']:
 for f in source['tracked_files']:
  path=source['destination']+'/'+f['path']
  assert staged[path]==(f['mode'],f['imported_blob']),'Git staged content differs: '+path
raw=subprocess.check_output(['git','-C',str(root),'ls-tree','-rz',manifest['original_target_commit']])
for entry in raw.split(b'\0'):
 if not entry:continue
 meta,path=entry.split(b'\t',1);mode,kind,sha=meta.decode().split();path=path.decode()
 if path=='README.md':continue
 assert staged[path]==(mode,sha),'Original target file differs: '+path
print('Staged imported blobs and original target files verified.')
