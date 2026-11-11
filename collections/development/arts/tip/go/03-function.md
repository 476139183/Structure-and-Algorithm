# GO函数

**go语言函数不可嵌套**

## 基本用法
使用`func <function_name>() {}`定义函数
```go
// 函数定义基本规则：
// func name (p1 p1_type, p2 p2_type) return_type {
//   <implement...>
// }

// 如果参数类型相同，可以统一写在最后，例如 add(a, b int)
func add(a int, b int) int {
  return a + b
}

// 函数的基本定义，注意支持多返回值
func today() (int, int, int) {
  return 2018, 12, 5
}
```

## 可变参数
```go
// 函数的可变参数用法
func min(nums ...int) int {
  m := nums[0]
  for _, n := range nums {
    if m > n {
      m = n
    }
  }

  return m
}
```

## defer关键字
```go
// defer关键字：指导函数返回时才被执行
func deferkey() {
  println("step1")
  defer println("step2 (with defer)")
  println("step3")
}
```

## 闭包
声明`add := func(a, b int) int { return a + b }`
```go
// 闭包(匿名函数)的用法
func anonyfunc() {
  println("闭包： ")

  add := func(a, b int) int { return a + b }
  println("add := func(a, b int) int { return a + b }")
  println("add(1, 2) => ", add(1, 2))

  println("func(a, b int) int { return a + b }(3, 4) => ", func(a, b int) int { return a + b }(3, 4))
}

// 回调函数
type cb func(s string)
func onEvent(name string, action cb) {
  action(name)
}
```