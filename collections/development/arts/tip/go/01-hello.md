# hello Go

## 第一个GO程序
filename: hello.go
```go
package main

func main() {
	println("hello world")
}
```

## 笔记
1. go源文件命名`filename.go`，如果文件名由多个单词构成则为`the_file_name.go`
2. 每个go源文件都**必须且仅能属于一个包**，在源的起始行声明:`package <pkg_name>`
3. `package main`具有特殊性，表示该文件为程序入口，可独立运行，每个go程序都会有一个main包
4. 使用`import "<pkg_name>"`导入依赖包，go将会根据依赖规则优先编译被依赖的源，确保每个源只编译一次
```go
// 多个包的导入方法
import "fmt"
import "os"

// 或者
import ("fmt"; "os") // 使用gofmt后，会被强制换行
```
5. 使用`import <alias> "<pkg_name>"`给包取别名，例如`import io "fmt"`
6. 使用`func <function_name>() {}`定义函数
