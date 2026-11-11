import json,pathlib,subprocess,os
root=os.environ.get('KNOWLEDGE_ROOT','/tmp/Structure-and-Algorithm-consolidation')
inventory=json.loads(pathlib.Path('/tmp/knowledge-sources-inventory.json').read_text())
results=[]
for r in inventory:
 if r['fork'] or r['name']=='Structure-and-Algorithm':continue
 name=r['name'];prefix='refs/tags/legacy/'+name+'/'
 p=subprocess.run(['git','-C',root,'fetch','--no-tags','--no-write-fetch-head','https://github.com/476139183/'+name+'.git','+refs/heads/*:'+prefix+'*'],capture_output=True,text=True)
 if p.returncode:raise RuntimeError(name+': '+p.stderr)
 refs=subprocess.check_output(['git','-C',root,'for-each-ref','--format=%(refname) %(objectname)',prefix],text=True)
 tags={line.split()[0]:line.split()[1] for line in refs.splitlines()}
 assert tags[prefix+r['branch']]==r['sha'],name+' changed since inventory'
 results.append({'name':name,'tags':tags})
 pathlib.Path('/tmp/knowledge-history-manifest.json').write_text(json.dumps(results,ensure_ascii=False,indent=2))
 print('HISTORY PRESERVED '+name+' '+str(len(tags))+' branches',flush=True)
print('ALL 11 SELF-CREATED HISTORIES PRESERVED',flush=True)
