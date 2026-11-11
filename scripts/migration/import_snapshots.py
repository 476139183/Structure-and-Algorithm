import concurrent.futures,hashlib,json,os,pathlib,subprocess,tarfile,time
ROOT=pathlib.Path(os.environ.get('KNOWLEDGE_ROOT','/tmp/Structure-and-Algorithm-consolidation'))
CACHE=pathlib.Path('/tmp/knowledge-source-downloads');CACHE.mkdir(exist_ok=True)
inventory=json.loads(pathlib.Path('/tmp/knowledge-sources-inventory.json').read_text())
groups={
 'algorithms':['algorithm-base','hello-algorithm','fucking-algorithm','swift-algorithm-club-cn','leetcode-zhuli','leetbook','leetCode'],
 'interviews':['interview','iOS-InterviewQuestion-collection','CodingInterviewChinese2'],
 'development':['TimLiu-iOS','study','iOS-Source-Probe','my-git'],
 'ios':['ReactiveCocoaLearn','Learning-iOS','LoopBannerView','iOS_AR','iOS-Demos','Learn-GCD','iOS-SimpleFTPClinet','YTToolPortal','iOS-wifi','CustomProgressView']}
destinations={n:'collections/'+group+'/'+n for group,names in groups.items() for n in names}
def import_one(r):
 name=r['name'];dest=ROOT/destinations[name];archive=CACHE/(name+'-'+r['sha']+'.tar.gz')
 if not archive.exists():
  part=archive.with_suffix('.part')
  with part.open('wb') as f:
   p=subprocess.run(['gh','api','repos/476139183/'+name+'/tarball/'+r['sha']],stdout=f,stderr=subprocess.PIPE)
  if p.returncode:raise RuntimeError(name+': '+p.stderr.decode(errors='replace'))
  part.rename(archive)
 dest.mkdir(parents=True,exist_ok=True)
 with tarfile.open(archive,'r:gz') as tar:
  for m in tar:
   parts=pathlib.PurePosixPath(m.name).parts[1:]
   if not parts:continue
   if '..' in parts or pathlib.PurePosixPath(*parts).is_absolute():raise RuntimeError('Unsafe archive path '+m.name)
   p=dest.joinpath(*parts)
   if m.isdir():p.mkdir(parents=True,exist_ok=True)
   elif m.isfile():
    p.parent.mkdir(parents=True,exist_ok=True)
    with tar.extractfile(m) as src,p.open('wb') as out:
     while block:=src.read(1024*1024):out.write(block)
    p.chmod(0o755 if m.mode&0o111 else 0o644)
   elif m.issym():
    target=pathlib.Path(m.linkname)
    if target.is_absolute() or not (p.parent/target).resolve().is_relative_to(dest.resolve()):raise RuntimeError('Unsafe symlink '+m.name)
    p.parent.mkdir(parents=True,exist_ok=True)
    if not p.is_symlink():p.symlink_to(m.linkname)
   else:raise RuntimeError('Unsupported archive entry '+m.name)
 count=0
 for f in r['tree']:
  if f['type']!='blob':continue
  p=dest/f['path']
  data=os.readlink(p).encode() if p.is_symlink() else p.read_bytes()
  actual=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
  if actual!=f['sha']:raise RuntimeError('Content mismatch '+name+'/'+f['path'])
  count+=1
 result={k:r[k] for k in ['name','id','fork','branch','sha','parent','license','pages','description','files','bytes']}
 result.update(destination=destinations[name],source_url='https://github.com/476139183/'+name,verification='All tracked default-branch blobs match Git object hashes',gitlinks=[f for f in r['tree'] if f['type']=='commit'])
 print('IMPORTED VERIFIED '+name+' '+str(count)+' files',flush=True)
 return result
with concurrent.futures.ThreadPoolExecutor(max_workers=4) as pool:
 futures={pool.submit(import_one,r):r['name'] for r in inventory if r['name'] in destinations}
 results=[]
 for future in concurrent.futures.as_completed(futures):
  results.append(future.result())
  pathlib.Path('/tmp/knowledge-import-progress.json').write_text(json.dumps(results,ensure_ascii=False,indent=2))
results.sort(key=lambda r:r['destination'])
pathlib.Path('/tmp/knowledge-import-manifest.json').write_text(json.dumps(results,ensure_ascii=False,indent=2))
print('ALL 24 SNAPSHOTS VERIFIED',flush=True)
