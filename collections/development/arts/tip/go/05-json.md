# JSON处理

GO对很多编码格式都有原生的支持，直接引用标准库`encoding`即可，从官网[Package encoding](https://golang.org/pkg/encoding/)的介绍中可知，当前支持`ascii85 / asn1 / base32 /base64 / hex / json / xml / ...`太多了。

这里主要学习和总结GO语言是如何序列化、反序列化JSON数据的。


## 序列化
```go
package main

import (
	"encoding/json"
	"fmt"
	"log"
)

type User struct {
	Name       string
	Password   string
	Permission uint16
}

var users = []User{
	{Name: "root", Password: "god", Permission: 777},
	{Name: "philon", Password: "hello", Permission: 755},
}

func main() {
	// 将users序列化为json字符串
	data, err := json.Marshal(users)
	// 上边的方法没有换行和缩进，不易读，可以用下面方式替代
	// data, err := json.MarshalIndent(users, "", "  ")

	if err != nil {
		log.Fatalf("json marshaling failed: %s", err)
	}

	fmt.Printf("%s\n", data)
}
```

```sh
$ go run main.go # 输入如下
[{"Name":"root","Password":"god","Permission":777},{"Name":"philon","Password":"hello","Permission":755}]
```

## 反序列化

```go
// 省略与序列化部分相同的内容

func main() {
	var list []User
	var data = `[{"Name":"root","Password":"god","Permission":777},{"Name":"philon","Password":"hello","Permission":755}]`
	if err := json.Unmarshal([]byte(data), &list); err != nil {
		log.Fatalf("json unmarshaling failed: %s", err)
	}

	fmt.Printf("%v\n", list)
}
```

```sh
$ go run main.go # 输入如下
[{root god 777} {philon hello 755}]
```