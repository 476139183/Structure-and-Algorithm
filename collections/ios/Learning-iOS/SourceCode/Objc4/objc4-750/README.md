# 配置 和 使用 objc4-750 源码 

### 准备工作
> 当前环境：Xcode Version 11.3.1 


去 [Apple Open Source](https://opensource.apple.com/tarballs/) 下载相关源码

1. 找到并下载对应的源码 [objc4-750.tar.gz](https://opensource.apple.com/tarballs/objc4/)

2. 其他需要引入的库 [已经配置好的](https://github.com/476139183/Structure-and-Algorithm/tree/master/collections/ios/Learning-iOS/SourceCode/OpenSource)

  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvlc96odyj310m0k4grc.jpg)
  * 我这里已经下载好，并且配置完毕，文件名 为 **include**

### 编译 

1. 使用 **Xcode** 打开我们下载好的工程文件 **objc.xcodeproj**

2. 先把不需要的 **TARGETS** 删掉

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvk7w6omhj31c60cgtb9.jpg)

3. 编译 objc 

* 问题1 
         
**`The i386 architecture is deprecated. You should update your ARCHS build setting to remove the i386 architecture.`**

* 解决：删除i386           
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvkajx8rvj31c20kiq9n.jpg)

* 问题2  
     
**`'sys/reason.h' file not found`** 和一系列的 其他文件 **`not found`**
 
  * 解决:将我们之前创建的文件夹 **include** 直接拖到工程
  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds2yxmr7ej31me0nqdto.jpg)
  * 在工程配置搜索 **User Header Search Paths**, 并添加路径 `${SRCROOT}/include`
  
  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds3405gwbj31ha0pwwmh.jpg)
  
* 问题3       
**`Use of undeclared identifier 'CRGetCrashLogMessage'`**
 * 解决：搜索 **`Preprocessor Macros`**,并添加 **`LIBC_NO_LIBCRASHREPORTERCLIENT `**
 
  ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvkfpzfacj31c20hm44k.jpg)


* 问题4                
报错**'objc/objc-block-trampolines.h' file not found**  
  * 解决:注释掉 代码 __`#include <objc/objc-block-trampolines.h>`__

* 问题5        
报错:**`can't open order file: /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.15.sdk/AppleInternal/OrderFiles/libobjc.order`**

 * 解决: 搜索 **`Order File`** 并替换成 **`$(SRCROOT)/libobjc.order`**

 ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvkmfgu58j31c40este4.jpg)
 
 
* 问题6     
报错：**`ld: library not found for -lCrashReporterClient`**
 * 解决：在 **Build Settings** -> **Linking** -> **Other Linker Flags**里删掉 "**-lCrashReporterClient**"（Debug和Release都删了）
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds55c8ngxj31ca0j610i.jpg)


* 报错 **/xcodebuild:1:1: SDK "macosx.internal" cannot be located.**
 * 解决：找到 **macosx.internal** 并修改为 **macosx** 
       ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvkqd8rbrj31am0l6jw7.jpg)


* 注意：
报错 **`no such public header file: '/tmp/objc.dst/usr/include/objc/ObjectiveC.apinotes'`**
 * 解决：搜索 **`Text-Based`** 操作如下：`Target->Build Settings->Other Text-Based InstallAPI Flags`里的内容设为空；
把 `Text-Based InstallAPI Verification Model`里的值改为 `Errors Only`。

> 这个报错，不一定会出现，所以我们应该提前解决。

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1ge2c9cr6ywj31c80gmtd6.jpg)
 
收尾：最后我们进行编译发现没有报错了。说明所有的工作都已经完成

--

### 使用
点击创建一个 TAG，我命名为 YTTest      
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gds58zw9faj318m0u0ara.jpg) 

然后添加依赖      
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvkyrij4qj31bw0j677h.jpg)

我们在自己建的TAG工程 main.m 文件里 

```objc
#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    Person *objc = [[Person alloc] init];
    NSLog(@"Hello, World!");
  }
  return 0;
}

```  
成功的断点，进入了 **alloc** 方法       
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvl29fv9ej31580oon2m.jpg)


## 结尾

如果需要知道 依赖库怎么配置的，可以参考这篇文章 [配置运行objc4-750和使用](https://www.jianshu.com/p/bbafd02ad0bb)