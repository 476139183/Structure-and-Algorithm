# GO数据类型

作为一个混迹IT行业多年的“油条”码农，如果还要从整型、字符串开始学习一门新语言，那我就真的只能搬砖了，所以关于go的基本语法我合在一起快速过一遍。

go的类型分为三种
- 基本类型： `int float bool string`
- 复合类型： `array struct slice map channel`
- 描述类型： `interface`

变量定义一般用`var <identifier> <type>`，需要注意**所有变量都是被初始化**，就算你不主动初始化它，关键字`var`类似与c++11的`auto`，可以不指定类型，前提是对定义的变量初始化，否则报错
```go
// var定义，变量为在没有初始化的情况下，自动初始化为0/nil/""等
var a int = 1
var b bool = false
var c string = "philon"

// 或者
var (
  a int
  b bool
  c string
)

// 如果觉得var a = 1这种方式比较繁琐，可以用':='代替
a := 1
b := false
c := "philon"
```

## 基本类型
### 布尔类型
- bool 只有true或false

### 整数
- int 32位系统4个字节，64位系统8个字节
- int8（-128 -> 127）
- int16（-32768 -> 32767）
- int32（-2,147,483,648 -> 2,147,483,647）
- int64（-9,223,372,036,854,775,808 -> 9,223,372,036,854,775,807）

### 无符号整数
- uint 与int同理
- uint8（0 -> 255）
- uint16（0 -> 65,535）
- uint32（0 -> 4,294,967,295）
- uint64（0 -> 18,446,744,073,709,551,615）

### 浮点型（IEEE-754 标准）
- 注意没有默认的float类型
- float32（+- 1e-45 -> +- 3.4 * 1e38）
- float64（+- 5 1e-324 -> 107 1e308）

### 复数
> go语言有复数类型，需要注意！！！复数使用 re+imI 来表示，其中 re 代表实数部分，im 代表虚数部分，I 代表根号负 1
- complex64 (32位实数或虚数)
- complex128 (64位实数或虚数)
```go
var c1 complex64 = 5 + 10i
fmt.Printf("The value is: %v", c1)
// 输出： 5 + 10i
```

### 字符串
大体上和其他语言的套路差不多，但要注意几点：
- 和 C/C++不一样，Go中的字符串是根据长度限定，而非特殊字符`\0`
- string类型的空值表示空字符串`""`，而不是地址为空
- 获取字符串长度`len(str)`
- 尽管go有指针，但不要尝试C/C++的技巧`&str[i]`，这是非法的

## 数组
声明方式：`var identifier [len]type`
```go
var arr [5]int

// 数组遍历
for i:=0 i < len(arr); i++ {
  arr[i] = i
}

for i, v := range arr {
  println("arr[", i, "] = " + v)
}
```

## 切片
> 切片相当于**长度可变的数组**

声明方式： `var identifier []type`，即不需要指定数组长度，默认为nil，长度为0
```go
// 切片初始化用arr[start:end]
var slice1 []int = arr[0:4]
var slice2 []int = []int{1, 2, 3}
```

## map
声明方式： `var map1 map[keytype]valuetype`
```go
// 声明及初始化
var map1 map[string]int
map1["key1"] = 1
map1["key2"] = 2

var map2 map[string]int = { "A": 1, "B": 2, "C": 3 }
```