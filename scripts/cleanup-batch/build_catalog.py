import datetime,hashlib,json,os,pathlib,posixpath,re,subprocess,urllib.parse
root=pathlib.Path(os.environ['KNOWLEDGE_ROOT']);config=json.loads((root/'scripts/cleanup-batch/config.json').read_text());target='https://github.com/476139183/'+config['target']
inventory=json.loads(pathlib.Path('/tmp/batch-sources-inventory.json').read_text());by_name={r['name']:r for r in inventory}
sources=json.loads(pathlib.Path('/tmp/batch-import-manifest.json').read_text());histories={r['name']:r['tags'] for r in json.loads(pathlib.Path('/tmp/batch-history-manifest.json').read_text())}
catalog=root/'catalog';catalog.mkdir(exist_ok=True);manifest_path=catalog/'manifest.json';append=manifest_path.exists()
if append:manifest=json.loads(manifest_path.read_text())
else:manifest={'schema':1,'target':target,'original_target_commit':by_name[config['target']]['sha'],'sources':[],'link_rewrites':[]}
assert not {s['name'] for s in sources}.intersection(s['name'] for s in manifest['sources'])
rewrites=[]
def blob(b):return hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()
for s in sources:
 base=root/s['destination']
 for f in by_name[s['name']]['tree']:
  if f['type']!='blob' or f['mode']=='120000' or not f['path'].lower().endswith(('.md','.markdown')):continue
  p=base/f['path'];before=p.read_bytes()
  try:text=before.decode('utf-8')
  except UnicodeDecodeError:continue
  def repair(m):
   u=urllib.parse.urlsplit(m.group('url'));dest=base/urllib.parse.unquote(u.path.lstrip('/'))
   if not dest.resolve().is_relative_to(base.resolve()) or not dest.exists():return m.group(0)
   relative=posixpath.relpath(dest.relative_to(base).as_posix(),p.parent.relative_to(base).as_posix())
   return m.group('prefix')+urllib.parse.quote(relative,safe='/@-_.~')+('?' + u.query if u.query else '')+('#'+u.fragment if u.fragment else '')
  text=re.sub(r'''(?P<prefix>\]\(\s*|(?:src|href)=["'])(?P<url>/(?!/)[^\s<>"')]+)''',repair,text)
  for other in sources:
   for kind in ['blob','tree']:text=text.replace(other['source_url']+'/'+kind+'/'+other['branch']+'/',target+'/'+kind+'/master/'+other['destination']+'/')
   text=text.replace('https://raw.githubusercontent.com/476139183/'+other['name']+'/'+other['branch']+'/','https://raw.githubusercontent.com/476139183/'+config['target']+'/master/'+other['destination']+'/')
  after=text.encode('utf-8')
  if before!=after:p.write_bytes(after);rewrites.append({'path':p.relative_to(root).as_posix(),'original_blob':blob(before),'imported_blob':blob(after)})
rewrite_map={r['path']:r['imported_blob'] for r in rewrites}
for s in sources:
 s['history_tags']=histories[s['name']];s['original_repository_status']='retained_pending_verification'
 s['tracked_files']=[{'path':f['path'],'mode':f['mode'],'source_blob':f['sha'],'imported_blob':rewrite_map.get(s['destination']+'/'+f['path'],f['sha'])} for f in by_name[s['name']]['tree'] if f['type']=='blob']
 text='# '+s['name']+'\n\n[打开归档目录](../'+s['destination']+'/) · [原 Fork]('+s['source_url']+')\n\n'
 text+='- 上游：https://github.com/'+s['parent']+'\n- 固定来源：`'+s['branch']+'` / `'+s['sha']+'`\n- 文件数：'+str(s['files'])+'\n'
 text+='- 许可证：`'+((s['license'] or {}).get('spdx_id') or '未识别')+'`；以原目录内的许可证与版权声明为准。\n- 原 Fork 状态：完成远端校验后删除。\n'
 text+='\n## 分支与标签历史\n\n'
 for ref in s['history_tags']:
  tag=ref.removeprefix('refs/tags/');text+='- ['+tag+']('+target+'/tree/'+tag+')\n'
 if s['name']=='Hikari':text+='\n主分支主要为说明文档；LLVM 混淆实现请查看上方 `release_60` 等归档分支。\n'
 text+='\n文件校验值和链接修复记录见 [manifest.json](manifest.json)。原有源码、资源及个人改动均保留；归档不代表已在当前系统编译运行。\n'
 (catalog/(s['name']+'.md')).write_text(text)
manifest['sources'].extend(sources);manifest['link_rewrites'].extend(rewrites);manifest['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();manifest['pending_cleanup']=[s['name'] for s in sources]
manifest['scope']='Source snapshots with per-source history and original-repository status recorded below; newly imported sources retain all branches and tags. See cleanup and pending_cleanup.'
manifest_path.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
labels={'algorithms':'算法与刷题','interviews':'面试资料','development':'开发资料','ios':'iOS 示例与组件','reverse':'逆向学习'}
allrows=[]
for group in {s['destination'].split('/')[1] for s in manifest['sources']}:
 rows=[]
 for s in manifest['sources']:
  if s['destination'].split('/')[1]!=group:continue
  rows.append('| ['+s['name']+']('+s['name']+'/) | '+('Fork' if s['fork'] else '自建')+' | '+(s.get('description') or '').replace('|','／').replace('\n',' ')+' | [来源记录](../../catalog/'+s['name']+'.md) |')
 (root/'collections'/group/'README.md').write_text('# '+labels[group]+'\n\n[返回总目录](../../README.md)\n\n| 项目 | 类型 | 内容 | 来源 |\n|---|---|---|---|\n'+'\n'.join(rows)+'\n')
for s in manifest['sources']:
 status={'deleted':'原库已删除','retained_for_compatibility':'原库保留兼容','retained_pending_verification':'待校验后删除'}.get(s.get('original_repository_status'),'原库保留')
 allrows.append('| ['+s['name']+']('+s['destination']+'/) | '+labels[s['destination'].split('/')[1]]+' | '+status+' | [详情](catalog/'+s['name']+'.md) |')
(root/'SOURCES.md').write_text('# 来源清单\n\n[返回总目录](README.md)\n\n| 项目 | 分类 | 原库状态 | 来源与版本 |\n|---|---|---|---|\n'+'\n'.join(allrows)+'\n')
if append:
 p=root/'README.md';text=p.read_text()
 old='此次迁入 24 个源仓库的默认分支文件；加上本仓库原有内容，共整理 25 个仓库。11 个自建源项目的各分支 Git 历史保存在 `legacy/项目名/分支名` 标签中；13 个第三方资料 Fork 保留文件快照。'
 assert old in text
 text=text.replace(old,'目前集中归档 28 个源仓库的文件，加上主仓库原有内容，共整理 29 个仓库。11 个旧自建项目和新增 4 个资料 Fork 的历史以归档标签保存；最初 13 个第三方资料 Fork 保留默认分支文件快照。')
 text=text.replace('## 原有算法笔记','新增资料：ARTS 学习记录、Swift 游戏开发教程、开源 iOS 应用合集和机器学习示例。新增来源的各分支、标签和个人 README 改动均已保存，原 Fork 待完成远端校验后删除。\n\n## 原有算法笔记')
 p.write_text(text)
else:
 original=subprocess.check_output(['git','-C',str(root),'show',manifest['original_target_commit']+':README.md']).decode('utf-8')
 intro='''# iOS 逆向学习库

保留原有微信 Hook 示例，集中整理非越狱注入、重签名、Hook 和 LLVM 混淆相关学习资料。

| 内容 | 入口 |
|---|---|
| 原有微信 Hook 示例 | 本仓库原有工程与下方教程 |
| iOS 非越狱逆向与注入 | [iOSAppHook](collections/reverse/iOSAppHook/) |
| Hikari 文档与 LLVM 混淆历史 | [Hikari 来源及代码分支](catalog/Hikari.md) |

[统一资料目录](collections/reverse/) · [来源、许可证与版本](SOURCES.md)

两个来源的默认分支文件独立保存，各分支和标签的完整历史保存在 `legacy/项目名/branches/分支名`、`legacy/项目名/tags/标签名` 中。Hikari 主分支主要是文档，实际 LLVM 实现可从来源页的 `release_60` 等归档分支查看。TKTweakDemo 原有工程、教程和历史保留。

原 Fork 待完成远端校验后删除。各目录保留各自许可证与版权声明，本库不统一重新授权第三方内容。旧工具未宣称已在当前系统编译或运行。

运行 `python3 scripts/verify_collections.py` 可核验文件及历史标签。

## 原有微信 Hook 教程

'''
 (root/'README.md').write_text(intro+original)
print('Catalog updated: '+str(len(sources))+' new sources, '+str(len(manifest['sources']))+' total sources.')
