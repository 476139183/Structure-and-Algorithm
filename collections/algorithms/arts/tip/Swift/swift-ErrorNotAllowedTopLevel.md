## Swift错误(error: expressions are not allowed at the top level)
以本项目为例，最初源文件为`test.swift`和`solution.swift`，编译命令为：
```shell
$ swiftc test.swift solution.swift -o test # 会得到如下错误提示
test.swift:4:1: error: expressions are not allowed at the top level
assert(s.twoSum(nums, -8) == [3, 5])
^
```
Google第一条就找到答案了，请[戳此](https://stackoverflow.com/questions/24642372/expressions-are-not-allowed-at-the-top-level-if-the-module-is-not-main-swift)看解答。

简单说明一下，swift是不允许在常规模块文件中包含顶层表达式的(top-level code)，所谓top-level就是非声明式语句，如赋值、定义、条件控制、函数调用等，只能写类、函数等声明与实现。但有一个例外——main.swift自带主角光环，以main.swift命名的源文件可以看作是个脚本文件，可随意写各种表达式，所以本项目很无奈地将test.swift更名为main.swift
