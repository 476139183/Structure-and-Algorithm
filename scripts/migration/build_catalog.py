import datetime,hashlib,json,os,pathlib,posixpath,re,subprocess,urllib.parse
ROOT=pathlib.Path(os.environ.get('KNOWLEDGE_ROOT','/tmp/Structure-and-Algorithm-consolidation'))
inventory=json.loads(pathlib.Path('/tmp/knowledge-sources-inventory.json').read_text())
imports=json.loads(pathlib.Path('/tmp/knowledge-import-manifest.json').read_text())
history=json.loads(pathlib.Path('/tmp/knowledge-history-manifest.json').read_text())
by_name={r['name']:r for r in inventory}
histories={r['name']:r['tags'] for r in history}
groups={'algorithms':('算法与刷题','算法图解、题解、Swift 算法示例及个人刷题记录。'),'interviews':('面试资料','面经、iOS 面试题与《剑指 Offer》代码。'),'development':('开发资料','iOS 资料索引、源码探究和 Git 学习资料。'),'ios':('iOS 示例与组件','RAC、源码学习、UI 组件、AR、网络与工具类示例。')}
catalog=ROOT/'catalog';catalog.mkdir(exist_ok=True)
target='https://github.com/476139183/Structure-and-Algorithm'
lookup={r['name']:r for r in imports}
rewrites=[]
def blob(data):return hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()
for r in imports:
 base=ROOT/r['destination'];branch=r['branch'];n=r['name']
 for f in by_name[n]['tree']:
  if f['type']!='blob' or f['mode']=='120000' or not f['path'].lower().endswith(('.md','.markdown')):continue
  p=base/f['path'];before=p.read_bytes()
  try:s=before.decode('utf-8')
  except UnicodeDecodeError:continue
  # Only repair root-relative links that resolved to a real file in this source.
  def local_link(m):
   raw=m.group('url');u=urllib.parse.urlsplit(raw)
   candidate=base/urllib.parse.unquote(u.path.lstrip('/'))
   if not candidate.resolve().is_relative_to(base.resolve()) or not candidate.exists():return m.group(0)
   relative=posixpath.relpath(candidate.relative_to(base).as_posix(),p.parent.relative_to(base).as_posix())
   return m.group('prefix')+urllib.parse.quote(relative,safe='/@-_.~')+('?' + u.query if u.query else '')+('#'+u.fragment if u.fragment else '')
  s=re.sub(r'''(?P<prefix>\]\(\s*|(?:src|href)=["'])(?P<url>/(?!/)[^\s<>"')]+)''',local_link,s)
  # Links to a migrated fork's files should survive eventual source deletion.
  for source in imports:
   source_name=source['name'];source_branch=source['branch'];dest=source['destination']
   for kind in ['blob','tree']:
    old='https://github.com/476139183/'+source_name+'/'+kind+'/'+source_branch+'/'
    s=s.replace(old,target+'/'+kind+'/master/'+dest+'/')
   old='https://raw.githubusercontent.com/476139183/'+source_name+'/'+source_branch+'/'
   s=s.replace(old,'https://raw.githubusercontent.com/476139183/Structure-and-Algorithm/master/'+dest+'/')
  after=s.encode('utf-8')
  if before!=after:
   p.write_bytes(after);rewrites.append({'path':p.relative_to(ROOT).as_posix(),'original_blob':blob(before),'imported_blob':blob(after),'reason':'Repair source-root links and migrated-repository file URLs'})
rewrite_map={r['path']:r for r in rewrites}
manifest={'schema':1,'created_at':datetime.datetime.now(datetime.timezone.utc).isoformat(),'target':target,'original_target_commit':by_name['Structure-and-Algorithm']['sha'],'scope':'Default-branch file snapshots of 24 repositories; all branch histories of 11 self-created sources retained as legacy tags. Source repositories have not been deleted.','sources':[],'link_rewrites':rewrites}
for r in imports:
 source=dict(r);source['history_tags']=histories.get(r['name'],{})
 source['tracked_files']=[]
 for f in by_name[r['name']]['tree']:
  if f['type']!='blob':continue
  path=r['destination']+'/'+f['path']
  source['tracked_files'].append({'path':f['path'],'mode':f['mode'],'source_blob':f['sha'],'imported_blob':rewrite_map.get(path,{}).get('imported_blob',f['sha'])})
 manifest['sources'].append(source)
 (catalog/(r['name']+'.md')).write_text('# '+r['name']+'\n\n'
  +'[打开归档目录](../'+r['destination']+'/) · [原仓库]('+r['source_url']+')\n\n'
  +'- 类型：'+('第三方资料 Fork' if r['fork'] else '自建项目')+'\n'
  +'- 来源默认分支：`'+r['branch']+'`\n- 固定提交：`'+r['sha']+'`\n'
  +'- 导入文件：'+str(r['files'])+' 个\n'
  +'- 上游：'+('https://github.com/'+r['parent'] if r['parent'] else '无，源仓库为自建项目')+'\n'
  +'- GitHub 识别的许可证：`'+((r['license'] or {}).get('spdx_id') or '未识别')+'`；以原目录内的许可证和版权声明为准。\n'
  +('- 历史保存：'+', '.join('`'+k.removeprefix('refs/tags/')+'`' for k in source['history_tags'])+'\n' if source['history_tags'] else '- 历史保存：本目录为默认分支文件快照，不包含源仓库的全部 Git 历史及其他分支。\n')
  +('- 原仓库启用了 GitHub Pages；该站点配置及网址尚未迁移。\n' if r['pages'] else '')
  +'\n原有项目目录、依赖、图片和许可证均保留。少数 Markdown 链接按新目录修复，改动记录在 [manifest.json](manifest.json) 中。归档不代表已在当前系统编译或运行。\n')
(catalog/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
allrows=[]
for group,(label,description) in groups.items():
 sources=[r for r in imports if r['destination'].split('/')[1]==group]
 rows=['| 项目 | 类型 | 内容 | 来源记录 |','|---|---|---|---|']
 for r in sources:
  rows.append('| ['+r['name']+']('+r['name']+'/) | '+('Fork' if r['fork'] else '自建')+' | '+(r['description'] or '原仓库未填写描述').replace('|','／').replace('\n',' ')+' | [版本与许可证](../../catalog/'+r['name']+'.md) |')
  allrows.append('| ['+r['name']+']('+r['destination']+'/) | '+label+' | '+('Fork' if r['fork'] else '自建')+' | [详情](catalog/'+r['name']+'.md) |')
 (ROOT/'collections'/group/'README.md').write_text('# '+label+'\n\n'+description+'\n\n[返回总目录](../../README.md)\n\n'+'\n'.join(rows)+'\n')
original=subprocess.check_output(['git','-C',str(ROOT),'show',by_name['Structure-and-Algorithm']['sha']+':README.md']).decode('utf-8')
intro='''# 算法与开发资料库

集中整理个人算法笔记、第三方学习资料，以及旧 iOS 示例项目。每个来源保留独立目录，避免同名文件覆盖；目录标注自建或 Fork，并记录来源、提交版本和许可证。

| 分类 | 内容 |
|---|---|
| [算法与刷题](collections/algorithms/) | 算法题解、数据结构、Swift 示例及刷题记录 |
| [面试资料](collections/interviews/) | 面经、iOS 面试题、《剑指 Offer》代码 |
| [开发资料](collections/development/) | iOS 资料索引、源码探究、Git 学习资料 |
| [iOS 示例与组件](collections/ios/) | RAC、UI、AR、网络与工具类示例 |

原有数据结构与算法目录、图片及下方笔记继续保留。

## 来源与迁移范围

此次迁入 24 个源仓库的默认分支文件；加上本仓库原有内容，共整理 25 个仓库。11 个自建源项目的各分支 Git 历史保存在 `legacy/项目名/分支名` 标签中；13 个第三方资料 Fork 保留文件快照。详见 [来源清单](SOURCES.md) 和 [迁移校验清单](catalog/manifest.json)。

原仓库尚未删除。Wiki、Issue、PR、发行附件及 Pages 站点不属于这次文件迁移；后续清理前需分别确认。旧项目保留原始依赖和工程结构，未宣称已适配当前 Xcode 或运行环境。

各目录继续适用来源项目的许可证与版权声明，本资料库不对第三方内容统一重新授权。未声明许可证的内容也不视为已获得新的使用许可。

运行 `python3 scripts/verify_collections.py` 可校验归档文件及历史标签。后续主动修改归档内容时，校验会报告差异，便于记录更新。

## 原有算法笔记

'''
(ROOT/'README.md').write_text(intro+original)
(ROOT/'SOURCES.md').write_text('# 来源清单\n\n[返回总目录](README.md)\n\n| 项目 | 分类 | 类型 | 来源与版本 |\n|---|---|---|---|\n'+'\n'.join(allrows)+'\n\n各项目完整提交号、来源地址、许可证、归档标签和文件校验值见对应详情页。原仓库 `Structure-and-Algorithm` 的内容保留在根目录。\n')
print('CATALOG BUILT: '+str(len(imports))+' sources, '+str(len(rewrites))+' Markdown files repaired')
