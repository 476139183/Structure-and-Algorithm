## Kotlin关于Int?与Int类型区别与转换
Kotlin的HashMap<K, V>用起来非常愉快，和Java没太大区别，但当需要hashmap.get(K)访问时会提示`Type mismatch(Int? to Int)`错误，这个问题的答案我在[stackoverflow](https://stackoverflow.com/questions/9562315/in-kotlin-how-can-i-convert-an-int-to-an-int)找到，总的来说解决Int?到Int类型转换有两种方法，如下：
```kotlin
// 不排除nullableDemo(null)这种调用方式
fun nullableDemo(a: Int?) {
    val b: Int = a      // 错误：因为a可以为空，b不行
    val c: Int = a!!    // 正确：编译器你听着，a不会空，传给c，这是命令!!
    if (a != null) {
        val d: Int = a  // 正确：代码既然能跑到这里，a还会是空？开玩笑
    }
}
```
Kotlin中<Type?>表示这是一个可能为空的变量，所以`<Type?> != <Type>`，而HashMap内存空间是动态分配的，因此hashmap.get(K)有可能为空，它的类型自然是Int?，如果非常确定它不可楞是一个空地址，那就勇敢的在后边追加`!!`操作符即可。