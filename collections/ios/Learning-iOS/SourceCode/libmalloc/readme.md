## 配置 和 使用 libmalloc-166.200.60  ##

### 准备工作 
> 当前环境：Xcode Version 11.3.1 

1. 找到并下载: [libmalloc-166.200.60.tar.gz](https://opensource.apple.com/tarballs/libmalloc/)

2. 其他需要引入的库 [已经配置好的](https://github.com/476139183/Structure-and-Algorithm/tree/master/collections/ios/Learning-iOS/SourceCode/libmalloc/OpenSource)

![](https://upload-images.jianshu.io/upload_images/9540884-e39e394c85bde735.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

将绿色的3个压缩包解压到桌面libs文件夹里面（libs文件夹是自己创建的，这里随便啥名字都行，主要是为了接下来文件缺失，直接查找用的）

> 这里已经配置好了，全部放在 **libInclude** 文件夹 里面

### 编译

1. 使用 **Xcode** 打开我们下载好的工程文件 **objc.xcodeproj**
2. 先把不需要的 **TARGETS** 删掉          
 把红框的都删掉，只留下 **libsystem_malloc**    
    
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvog3lc4bj315i0nu7ed.jpg)

3. 将不需要的文件夹删掉

删除 文件夹`resorver`、`tests`、`xcodeconfig` 、`tools` 以及 Frameworks 文件夹下面的 两个库   

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvol2r46aj30sq0jiqfi.jpg)

4. 继续删除不需要的文件

搜索  `radix_tree `。 将对应的文件删除,并注释引入的代码     

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvoteloluj30og0i8tmt.jpg)
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvq57am1oj31040ryk1d.jpg)

5. 开始编译

* 问题1 **`'_simple.h' file not found`** 以及一系列的文件 **`not found`**

 * 解决：       
 将我们之前的整理好的文件夹 **libInclude** 中的 部分文件 拖进工程的 **include** 文件夹下面      
 ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvph834zfj30zy0r4qd8.jpg)
 
 在工程配置搜索 **User Header Search Paths**, 并添加路径 **${SRCROOT}/include**
 
 ![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvpjuf22gj315y0fk0x3.jpg)
 

* 问题2  使用未声明的的宏定义
**`Use of undeclared identifier '_COMM_PAGE_MEMORY_SIZE'`**

 * 解决：导入编写好的宏文件 **Header.h**,并在 文件 **`magazine_inline.h`** 引入头文件
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvpsmvnbnj31bm0m0gzv.jpg)
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvpu026e7j31c20quh4s.jpg)
 
 * 问题3 使用未声明的标识符 **`Use of undeclared identifier '_COMM_PAGE_VERSION'`**
 
  * 解决：找到函数 `create_scalable_szone` 注释相关代码
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvpxu9chpj30zy0fqjw2.jpg)
  
* 问题4 ：文件未找到**`'resolver.h' file not found`**
  * 解决：删除 有关 `nanov2` 的文件
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvq1660qij30pa0juwrm.jpg)

  * 后续：删除或者注释 所有 有关 **nanov2** 的代码
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvq2q88ngj30v00jswjs.jpg)
  
* 问题5: `Use of undeclared identifier 'NOTE_MEMORYSTATUS_MSL_STATUS'` 以及 `Use of undeclared identifier 'NOTE_MEMORYSTATUS_PRESSURE_WARN'`等。
  * 注释掉 整个函数 **`handle_msl_memory_event`** 和 **`malloc_memory_event_handler`**

* 问题6： **`Use of undeclared identifier 'nanozonev2_t'`**
  * 解决：定位到 函数 **`_malloc_fork_child`** 将报错函数注释，并修改: 
       
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvqfcc7elj30y40fwn15.jpg)
> **`nano_forked_zone((nanozone_t *)inline_malloc_default_zone());`**

* 问题7: **`Undefined symbol: _nanov2_configure `**
  * 解决： 搜索 **nanov2_configure**,并注释掉
  
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdvqnjdz73j319q0n8wxx.jpg)


* 问题7: **`Undefined symbol: _nanov2_create_zone`**  
  * 解决：搜索 **nanov2_create_zone**,并注释掉
  
 
  * 解决：搜索 **nanov2_create_zone**,定位到代码，并进行修改如下：
  
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdwi16h58lj31lu0gaqho.jpg)
> **`zone = nano_create_zone(helper_zone, malloc_debug_flags);`**

* 问题8: **`Undefined symbol: _nanov2_init`**
 * 解决： 搜索 **nanov2_init**,并注释
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdwi3am2jdj31m40bmwnu.jpg)

* 问题9: 
    * 1. **`Undefined symbol:_radix_tree_create`**
    * 2. **`Undefined symbol:_radix_tree_size`**
    * 3. **`Undefined symbol:_radix_tree_insert`**
 * 解决：搜索 **radix_tree_create**,直接注释相关代码

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdwib61xnfj31lu0qutz9.jpg)

* 问题10:**`Undefined symbol:_radix_tree_delete`**
 * 解决：搜索 **radix_tree_delete**,直接注释相关代码
 
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdwicz7l9cj31lu0g87kh.jpg)

* 问题11: **`Undefined symbol:_radix_tree_lookup`**
 * 解决： 搜索 **radix_tree_lookup**,直接注释相关代码


##### 编译没有报错,代码配置完毕

### 测试

新建一个 Target ,命名为 **YTTest**,并进行依赖配置

![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdwihi84u1j31e60pm42y.jpg)

在对应的代码编写

```objc
#import <Foundation/Foundation.h>
#import <malloc/malloc.h>

int main(int argc, const char * argv[]) {
  @autoreleasepool {
	void *p = calloc(1, 24);
	NSLog(@"%lu",malloc_size(p));
  }
  return 0;
}

```

编译 我们的 YTTest，代码奔溃
![](https://tva1.sinaimg.cn/large/007S8ZIlgy1gdwile5g0fj316w0og12c.jpg)

我们注释这段奔溃代码

```objc
//MALLOC_ASSERT(_malloc_engaged_nano == NANO_V1);
```

再次编译，我们可以成功进入 malloc 源码了。

## 结尾 ##

如果需要知道 依赖库怎么配置的，可以参考这篇文章 [libmalloc-166.200.60之源码编译](https://www.jianshu.com/p/cb1b573a0297)