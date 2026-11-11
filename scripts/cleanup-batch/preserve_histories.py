import json,os,pathlib,subprocess
root=os.environ['KNOWLEDGE_ROOT'];inventory=json.loads(pathlib.Path('/tmp/batch-sources-inventory.json').read_text());results=[]
config=json.loads((pathlib.Path(root)/'scripts/cleanup-batch/config.json').read_text());names={n for ns in config['groups'].values() for n in ns}
for r in inventory:
 if r['name'] not in names:continue
 name=r['name'];prefix='refs/tags/legacy/'+name+'/'
 p=subprocess.run(['git','-C',root,'fetch','--no-tags','--no-write-fetch-head','https://github.com/476139183/'+name+'.git','+refs/heads/*:'+prefix+'branches/*','+refs/tags/*:'+prefix+'tags/*'],capture_output=True,text=True)
 if p.returncode:raise RuntimeError(name+': '+p.stderr)
 refs=subprocess.check_output(['git','-C',root,'for-each-ref','--format=%(refname) %(objectname)',prefix],text=True)
 tags={line.split()[0]:line.split()[1] for line in refs.splitlines()}
 assert tags[prefix+'branches/'+r['branch']]==r['sha'],name+' changed since inventory'
 results.append({'name':name,'tags':tags})
 pathlib.Path('/tmp/batch-history-manifest.json').write_text(json.dumps(results,ensure_ascii=False,indent=2))
 print('HISTORY PRESERVED '+name+' '+str(len(tags))+' branch/tag refs',flush=True)
