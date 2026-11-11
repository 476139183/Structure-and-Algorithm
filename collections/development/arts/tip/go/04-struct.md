# 结构体
GO语言中没有类的概念，不是面向对象语言，但可以通过类型别名和结构体的形式实现面向对象的一些特点。

## 用面向对象思想看结构体
### 属性
`type identifier struct { field_name field_type tag }`是结构体的基本定义格式，和C/C++类型，结构体是一个符合类型，简单理解为多个类型的组合定义，好比只能定义属性字段的类，下面以定义一个“员工类”为实例具体说明：
```go
// Employee是结构体的基本定义方式，可以看作是类的属性
type Employee struct {
  name   string  "full name"
  age    int
  salary int "monthly salary"
  post   string
}

// 调用方法
me := Employee{name: "Philon", age: 30, salary: 6666, post: "coding"}
// 或者通过指针的方式
me := new(Employee)
```
**注意**：tag标签一般情况下可以省略，只有`reflect`包可以获取到标签值

### 方法
`func (self Type) name() { <implement> }`
定义了员工的属性之后，可能还需要一些方法，GO可以为结构体定义自己的方法，但和Java、.net真正的面向对象语言不一样，GO的结构体方法定义在其外部，接着上边的例子来看：
```go
type Employee struct { ... }

// work和getSalary是Employee的方法
func (e Employee) work()      { println(e.name + " is " + e.post) }
func (e Employee) getSalary() { println(e.name + " get " + strconv.Itoa(e.salary)) }
```

### 继承与重载
和面向对象一样，不论属性还是方法，都可以继承或者重载(覆盖掉之前的定义)，此时需要用到GO语言的`内联结构体和匿名字段`的概念：
```go
type Struct1 struct {
  a string
  b int
  float32 // 这是一个匿名字段，没有字段名
}

type Struct2 struct {
  Struct1 // 继承了Struct1，内部结构体，也是一个匿名字段
  c bool
  d []int
}

// 可以这么玩
s2 := new(Struct2)
s2.a = "123"
s2.b = 456
s2.c = false
```
继承与重载是GO语言比较有意思的地方，我个人觉得通过内联结构体和匿名字段的机制，同时兼顾了多重继承的优势和代码的简洁性，还是以Employee为例，如我需要在此之上继承一个Manager类，可以这样做：
```go
// Manager 通过匿名字段和内联结构体的方式，继承于Employee
type Manager struct {
  Employee
  salary [2]int  // 重载了Employee的字段
}

// 重载Employee的getSalary方法
func (e Manager) getSalary() {
	println(e.name + " get salary: " + strconv.Itoa(e.salary[0]) + " & bonus: " + strconv.Itoa(e.salary[1]))
}

// 调用方法
he := Manager{}
he.name = "Shit"
he.age = 40
```

## 实例
```go
package main

import "strconv"

// Employee 是一个结构体，相当于面向对象中的“类”
type Employee struct {
  name   string "full name"
  salary int    "monthly salary"
  post   string "coding/manages"
}

// 定义结构体方法
func (e Employee) work()      { println(e.name + " is " + e.post) }
func (e Employee) getSalary() { println(e.name + " get " + strconv.Itoa(e.salary)) }

// Manager 继承于Employee
type Manager struct {
  Employee
  salary [2]int // 字段重载
}

// 方法重载
func (e Manager) getSalary() {
  println(e.name + " get salary: " + strconv.Itoa(e.salary[0]) +
                 " & bonus: " + strconv.Itoa(e.salary[1]))
}

func main() {
  me := Employee{name: "Philon", salary: 6666, post: "coding"}
  he := Manager{}
  he.name = "Shit"
  he.post = "talking"
  he.salary = [2]int{8888, 1111}

  he.work()      // Shit is talking
  me.work()      // Philon is coding
  he.getSalary() // Shit get salary: 8888 & bonus: 1111
  me.getSalary() // Philon get 6666
}

```