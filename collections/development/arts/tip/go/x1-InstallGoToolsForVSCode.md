# VSCode安装GO语言依赖工具
由于vscode对go语言的支持还是hin不错滴，所以我日常学习go都用vscode，但这货有个毛病，各种lint、补全、nav、调试都依赖go语言的其他扩展工具，如果安装补全，会给出类似提示：
```
The "gocode" command is not available. Use "go get -v github.com/mdempsky/gocode" to install.
```
但如果按照vscode的提示点击“安装”后，经过漫长等待，会迎来进一步提示：
```
gocode:
Error: Command failed: /usr/local/go/bin/go get -u -v github.com/mdempsky/gocode
github.com/mdempsky/gocode (download)
Fetching https://golang.org/x/tools/go/gcexportdata?go-get=1
https fetch failed: Get https://golang.org/x/tools/go/gcexportdata?go-get=1: dial tcp 216.239.37.1:443: i/o timeout
package golang.org/x/tools/go/gcexportdata: unrecognized import path "golang.org/x/tools/go/gcexportdata" (https fetch: Get https://golang.org/x/tools/go/gcexportdata?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
```
What's the fuuuuuuu!!!

必须说明我是在科学上网的前提下执行的安装命令，所以猜测不是网络问题，具体原因没深究，我参考了[官方指导](https://github.com/Microsoft/vscode-go/wiki/Go-tools-that-the-Go-extension-depends-on)以及[一篇博文](http://www.pythonsite.com/?p=429)解决的该问题，博客写得有点绕，我挑简单的总结一下。

## 解决方案
从官方文档中可以明确，VSCode依赖的几款工具完成不同功能：

|名称|描述|链接
|-|-|-|
|gocode|代码自动补全|https://github.com/mdempsky/gocode
|go-outline|在当前文件中查找|https://github.com/ramya-rao-a/go-outline
|go-symbols|在项目路径下查找|https://github.com/acroca/go-symbols
|gopkgs|自动补全未导入包|https://github.com/uudashr/gopkgs
|guru|查询所有引用|https://golang.org/x/tools/cmd/guru
|gorename|重命名符号|https://golang.org/x/tools/cmd/gorename
|goreturns|格式化代码|https://github.com/sqs/goreturns
|godef|跳转到声明|https://github.com/rogpeppe/godef
|godoc|鼠标悬浮时文档提示|https://golang.org/x/tools/cmd/godoc
|golint|就是lint|https://golang.org/x/lint/golint
|dlv|调试功能|https://github.com/derekparker/delve/tree/master/cmd/dlv
|gomodifytags|修改结构体标签|https://github.com/fatih/gomodifytags
|goplay|运行当前go文件|https://github.com/haya14busa/goplay/
|impl|新建接口|https://github.com/josharian/impl
|gotype-live|类型诊断|https://github.com/tylerb/gotype-live
|gotests|单元测试|https://github.com/cweill/gotests/
|go-langserver|语言服务|https://github.com/sourcegraph/go-langserver
|filstruct|结构体成员默认值|https://github.com/davidrjenni/reftools/tree/master/cmd/fillstruct

以上的工具可以有选择地安装，但为了开发过程中不要出什么岔子，我一般选择全部安装，很不幸的是安装过程中80%的工具会出现`timeout`的提示。  

### 安装步骤
为了统一每个人的开发环境，下文中`GOPATH`表示自己电脑go的安装路径，例如我的电脑默认安装路径为`~/go`，如果没有的话建议先执行命令`export GOPATH=~/go`，Windows用户...👋

1. 创建目录`$GOPATH/src/golang.org/x`，并切换到该目录
```bash
mkdir -p $GOPATH/src/golang.org/x/
cd $GOPATH/src/golang.org/x/
```
2. 克隆golang.org工具源码  
如果不克隆的话，`go get -u -v golang.org/xxx`肯定是timeout的，所以只能先把它们下载到本地`src/golang.org/x/tools`
```bash
git clone https://github.com/golang/tools.git
git clone https://github.com/golang/lint.git
```
3. 下载github源码  
按照`go get -u -v`命令，从GitHub上下载代码后还会`fetch`，我们很可能会在`fetch https://golang.org/xxx`的时候挂掉，原因你懂的。所以去掉`-u`选项，禁止从网络更新现有代码。
```bash
# 先从github下载依赖工具的源码，fetch提示timeout不要管
go get -v github.com/ramya-rao-a/go-outline
go get -v github.com/acroca/go-symbols
go get -v github.com/mdempsky/gocode
go get -v github.com/rogpeppe/godef
go get -v github.com/zmb3/gogetdoc
go get -v github.com/fatih/gomodifytags
go get -v sourcegraph.com/sqs/goreturns
go get -v github.com/cweill/gotests/...
go get -v github.com/josharian/impl
go get -v github.com/haya14busa/goplay/cmd/goplay
go get -v github.com/uudashr/gopkgs/cmd/gopkgs
go get -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -v github.com/alecthomas/gometalinter
```

4. 安装工具
```bash
go install github.com/ramya-rao-a/go-outline
go install github.com/acroca/go-symbols
go install github.com/mdempsky/gocode
go install github.com/rogpeppe/godef
go install github.com/zmb3/gogetdoc
go install github.com/fatih/gomodifytags
go install sourcegraph.com/sqs/goreturns
go install github.com/cweill/gotests/...
go install github.com/josharian/impl
go install github.com/haya14busa/goplay/cmd/goplay
go install github.com/uudashr/gopkgs/cmd/gopkgs
go install github.com/davidrjenni/reftools/cmd/fillstruct
go install github.com/alecthomas/gometalinter
$GOPATH/bin/gometalinter --install
go install golang.org/x/tools/cmd/godoc
go install golang.org/x/lint/golint
go install golang.org/x/tools/cmd/gorename
go install golang.org/x/tools/cmd/goimports
go install golang.org/x/tools/cmd/guru
```

5. 集成到系统环境中  
由于我是在用户目录下临时安装的，真正的GO环境是`/usr/local/go`，所以最后一步无比注意，把`~/go/bin`下面生成的所有执行文件拷贝到系统环境中
```bash
sudo cp -af $GOPATH/bin/* /usr/local/go/bin/
```

打完收工！