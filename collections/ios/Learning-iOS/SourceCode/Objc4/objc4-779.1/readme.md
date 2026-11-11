
### 准备工作

> `mac 版本 10.15.4` 

去 [Apple Open Source](https://opensource.apple.com/tarballs/) 下载相关源码

1. 找到并下载最新的源码 [objc4-779.1.tar.gz](https://opensource.apple.com/tarballs/objc4/)

2. 其他需要引入的库 [已经下载好的]()

  * 我这里已经下载好，并且配置完毕，文件名 为 **include**

### 编译 

1. 使用 **Xcode** 打开我们下载好的工程文件 **objc.xcodeproj**

2. 先把不需要的 **TARGETS** 删掉

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdry6ppskij31ca0fo79c.jpg)

3. 编译 objc 

* 问题1     
**`unable to find sdk 'macosx.internal'`**
  
 * 解决:找到 **macosx.internal** 并修改为 **macosx**
      ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdryb5lsv8j31ca0n4gqz.jpg)
 * 修改 **BaseSDK**
      ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdrydzbikaj31c80fm128.jpg)

* 问题2       
**`'sys/reason.h' file not found`** 和一系列的 其他库 **`not found`**
 
  * 解决:将我们之前创建的文件夹 **include** 直接拖到工程
  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds2yxmr7ej31me0nqdto.jpg)
  * 在工程配置搜索 **User Header Search Paths**, 并添加路径 `${SRCROOT}/include`
  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds3405gwbj31ha0pwwmh.jpg)
  
* 问题3       
**`Use of undeclared identifier 'CRGetCrashLogMessage'`**
 * 解决：搜索 **`Preprocessor Macros`**,并添加 **`LIBC_NO_LIBCRASHREPORTERCLIENT `**
 
  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds3p2mzqij31c20ju7ba.jpg)

* 问题4
报错:**`'objc/objc-block-trampolines.h' file not found`**
 * 解决：定位到问题，将文件引入改为如下所示
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1ge6zacxkd1j30zg0bwad9.jpg)

* 问题5 
报错:**`can't open order file: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/AppleInternal/OrderFiles/libobjc.order`**

 * 解决: 搜索 `Order File`， 并修改为 `$(SRCROOT)/libobjc.order`

 ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds52z29erj31c60dmjwl.jpg)
 
 
* 问题6 
报错：`ld: library not found for -lCrashReporterClient`

在 Build Settings -> Linking -> Other Linker Flags里删掉"-lCrashReporterClient"（Debug和Release都删了）
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds55c8ngxj31ca0j610i.jpg)

收尾：最后我们进行编译发现没有报错了。说明所有的工作都已经完成

--

### 使用
点击创建一个 TAG，我命名为 YTTest
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds58zw9faj318m0u0ara.jpg) 

然后添加依赖      
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvkyrij4qj31bw0j677h.jpg)

我们在自己建的TAG工程 main.m 文件里 

```objc
int main(int argc, const char * argv[]) {
  @autoreleasepool {
    // insert code here...
    NSLog(@"Hello, World!");
    
    [[Person alloc] init];
  }
  return 0;
}
```

就能定位到底层代码了
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1ge6zm0bbqtj315605igo9.jpg)
