# ReactiveCocoaLearn
>> 随意玩玩的 [RAC Demo](https://github.com/476139183/ReactiveCocoaLearn)

![](http://cc.cocimg.com/api/uploads/20160729/1469775435531028.png)

## 第一章 ##

介绍和简单的使用的两种 信号，

#### 1. 基类信号 `RACSignal`   
 
   通过方法 `createSignal` 创建信号，传入一个 block, 我们记为 `didSubscribe` ，在 `didSubscribe ` 里面，我们 使用 `RACSubscriber` 对象（订阅者）进行发送信号，我们称之为 `发送订阅信号`，方法为 `sendNext `。此时信号 为 **冷信号**。 只有我们在进行订阅时，才进行消息的发送。 而订阅方法 是 `subscribeNext`
  
  在这个基类信号中，我们可以看到signal中值的流向，以及监听signal的本质。各个block之间，一个扣着一个，代码的初始可读性可能比较难理解，但是真正理解之后，你会发现RAC真的很神奇。
  
完整示例代码如下：  

```objc 
//! TODO: 1.创建信号（冷信号） -> 返回的是子类 RACDynamicSignal 
 //! 抛出 didSubscribe block
  RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
    //TODO: 3. 在主线程，使用 RACSubscriber 订阅者对象 发送信号
    [subscriber sendNext:@"发送一个对象"];
    
    return [RACDisposable disposableWithBlock:^{
      /* TODO: 
      信号自动销毁
      最后生成的 RACDisposable 会调用 销毁block，
      这一步发生 在最后  addDisposable 方法里面
      */
      NSLog(@"信号销毁");
    }];
  }];
  
  /*!  
  TODO: 2.订阅信号 调用 RACDynamicSignal 的 父亲类的 subscribeNext 方法，
  里面生成 RACSubscriber 对象，
  再调用 自己实现的 subscribe 发送信号的方法。调用创建信号时，在保存的block
  发送信号之后， 返回 RACDisposable 对象
  */
  RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
    // x:收到的信号
    NSLog(@"收到的信号：%@",x);
  }];
```  

> 可以发现，我们每订阅一次信号(也就是 `subscribeNext ` 操作)，都会触发block1一次，也就是会多次创建订阅者，并进行消息发送。
  
#### 2. 信号子类 `RACSubject` 
 
子类将父类的方法进行封装后，我们一般使用 `[RACSubject subject]` 进行信号创建，同样使用`subscribeNext` 进行消息的订阅，进行消息的接收，由于做了封装处理，我们可以随时在任何时机进行消息的发送，比如 `[subject sendNext:@"子类信号"]`.  
 
 可以发现， `RACSubject` 继承了 `RACSubscriber ` 协议，所以  `RACSubject` 本身也可以发送信号，也就是说， `RACSubject` 既是订阅者也是发布者，它不需要订阅，也可以发送信号，所以它是 **热信号**
      
 `RACSubject` 已经是常用的信号类了，比如 我们可以使用一个中间类持有 `RACSubject `,并在控制器类里面进行信号的创建，在中间类编写网络请求，在网络回调的时候，使用 `[subject sendNext:(id)(接收到的数据对象)]` 将数据发送到控制器处理。

> 不同于其父类，`RACSubject` 可 多次订阅

使用代码如下：
  
```objc
 //! 1. 创建信号，建立一个销毁对象和一个数组 _subscribers
  RACSubject *subject = [RACSubject subject];
  /* 2. 订阅信号, 调用父类方法，并重写里面的 subscribe 方法。
      拿到之前的_subscribers 只保存这个订阅者，并未触发其他方法
  */
  [subject subscribeNext:^(id  _Nullable x) {
    NSLog(@"接受到了数据:%@",x);
  }];
  
  //!3. 发送数据
  //遍历出所有的订阅者,调用nextBlock
  [subject sendNext:@"子类信号"];
 ```

  
具体使用可以详见 `第一章` 的 工程 

## 第二章 ##

对基本数据类型进行操作

### RACTuple ###

里面出现了新的一种数据类型，我们称之为 元组 `RACTuple`,这是对数组的进一步封装，里面可以放入任何的数据类型，包括基本数据类型，但是在OC中数组只能存储对象。
比如 我们可以创建一个元组

```objc
  RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"我",@"才刚到",@(12)]];

```
而解析的时候，除了和常规的数组一样 使用[]进行角标解析，还可以直接使用宏定义进行解析，如下

 ```objc
   RACTupleUnpack(NSString *name, NSString *action, NSNumber *age) = tuple;

 ```
此时，name，action，age 都一一绑定赋值

具体的使用方法可以去工程 `第二章` 查看。

### RACSequence ###
序列，也就是存放一系列数据的集合，这个类可以用来代替我们的NSArray或者NSDictionary，主要就是用来快速遍历，和 用来字段转模型的。

比如下面的数组 

```objc
  NSArray *arr = @[@"我",@"真",@"的",@"才",@(12)];

```

我们可以通过创建 `RACSequence` 对象进行遍历，

```objc
   RACSequence * requence = [arr rac_sequence];
   RACSignal * signal = [requence signal];
   [signal subscribeNext:^(id  _Nullable x) {
     NSLog(@"%@",x);
   }];

```
将数组的内容打印处理，但看起来并没有什么卵用，因为你写了3行复杂的代码就为了一个数组的遍历，别急，我们RAC是链式编程，我们可以进一步代码缩减，如下

```objc
  [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"%@",x);
  }];
```
代码瞬间简洁，和 `enumerateObjectsUsingBlock` 系列对比，代码紧凑多了

>> 遍历回调是异步线程回调，如果想要刷新UI需要回主线程进行刷新

当然，对数组的遍历进行了简化，怎么能忘记字典呢，同样， `RACSequence ` 也可以对字典进行遍历，如下

```objc
  NSDictionary *dic = @{
                        @"name":@"段",
                        @"age":@(12)
                        };
  
  NSLog(@"字典解析\n");
  [dic.rac_sequence.signal subscribeNext:^(RACTwoTuple *x) {
    RACTupleUnpack(NSString *key,NSString *value) = x;
    NSLog(@"%@=%@",key,value);
  }];

```
由于同时遍历key和value，所以RAC将其放入了元组之中，我们通过宏定义解析，赋值，得到字典的key和对应的value.

很多时候我们需要处理网络请求的数据，进行模型转换，我们可以使用 `map` 方法，官方解释是对数据进行映射，下面我们模仿一下数据的转换

```objc
NSString * filePath = [[NSBundle mainBundle] pathForResource:@"people.plist" ofType:nil];
  NSArray * dictArr = [NSArray arrayWithContentsOfFile:filePath];
  NSLog(@"复杂数据解析\n");
  /* 未优化的操作
   NSMutableArray * modelArr = [NSMutableArray array];
   [dictArr.rac_sequence.signal subscribeNext:^(NSDictionary * x) {
     PeopleModel *perple = [PeopleModel mj_keywithVaule:x];
     [modelArr addObject:perple];
   }];
   */
  ///! 整合之后，链式编程
  NSArray *modelArr = [[dictArr.rac_sequence.signal map:^id _Nullable(id  _Nullable value) {
    NSLog(@"value");
    return [PeopleModel mj_keywithVaule:value];
    
  }] toArray];

  NSLog(@"%@",modelArr);

```
当然我们常使用的 YYmode 和 MJExtension 本身也提供了类似的方法对数据进行模型转换后 更为方便的转为数组接收。代码可以详见 `第二章` demo.


## 第三章 ##

主要是尝试了一些简单的用法，包括我们常用的场景，比如事件的监听，定时器，和常用的RAC宏

### 事件的监听 ###

* 1. 监听未公开方法

在 `EventsVC` 控制器里面，尝试了几种常用的监听，比如在我们可以监听到类的私有方法(未申明在.h文件)

```objc
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
  //TODO: 监听内部方法调用
  [[testView rac_signalForSelector:@selector(clickButton:)] subscribeNext:^(RACTuple * _Nullable x) {
    NSLog(@"发现调用了clickButton方法");
  }];
#pragma clang diagnostic pop

```

为了去掉警告，进行了忽略，可以发现，我们监听的时候，收到消息 发生在 内部的方法 `clickButton ` 之后，这个小细节我们需要注意。

* 2. 监听点击事件

比如我们监听到了按钮的点击事件

```
    __weak typeof(self) weakSelf = self;
    [[_sender rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
      NSLog(@"点击按钮%@",x);
      [weakSelf clickButton:x];
    }];
```

以及 文本框的输入

```
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
      NSLog(@"输入:%@",x);
    }];

```

* 3. 代替 KVO 和 通知 

```
    //!TODO: 2. 代替KVO
    [self.sender rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
      NSLog(@"frame.value\n%@\n%@",value,change);
    }];

    //TODO: 1. 代替通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
      NSLog(@"键盘出现%@",x);
    }];

```

好处明显，我们发现不需要我们自己去做移除了

* 4. 监听代理

```
    @weakify(self);
    RACDisposable *cancelDisposable = [[_supViewController rac_signalForSelector:@selector(imagePickerControllerDidCancel:)] subscribeNext:^(RACTuple *tuple) {
      DLog(@"取消了照相");
      RACTupleUnpack(UIImagePickerController *picker) = tuple;
      [picker dismissViewControllerAnimated:YES completion:nil];
      @strongify(self);
      if (self.completionBlock) {
        self.completionBlock(nil);
      }
    }];
```

该方法并未写入到 Demo 里面去，在我app里面，因为 `UIImagePickerController` 的一些协议的遵守者要求是控制器，而我在进行开发的时候，使用了 `NSObject` 对象进行异步管理,故而采用了监听代理的方法去实现。

### 定时器 ###

我们可以通过 

```
  [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]]
```
创建一个定时器信号，该信号对 GCD 进行了封装，具体的代码实现可以在工程 `第三章` 查看,需要注意的是，我们要记得取消订阅 

```
  [self.disposable dispose];
```

### 宏定义 ###

1. 数据绑定    
我们可以直接将输入框的文本，绑定到 `label` 上的 `text`属性， 这样一旦输入框的文本改变，那么文本内容会直接赋值给属性！

```
  RAC(_label,text) = _field.rac_textSignal;
```

2. KVO
简化 RAC的KVO写法,需要注意的是，初次监听 就会触发一次

```
  [RACObserve(self.label, text) subscribeNext:^(id  _Nullable x) {
    NSLog(@"发现label变化%@",x);
  }];
  
```

3. 包装元祖
之前已经解释了 元祖， 也用到了宏定义，这里不再赘述 

```
  //包装元祖
  RACTuple * tuple = RACTuplePack(@1,@2);
  //解包!!
  RACTupleUnpack(NSNumber *number1,NSNumber *NSNumber2) = tuple;
  
  NSLog(@"%@,%@",number1,NSNumber2);

```

 常用的一些宏定义已经列出来了，详细的可以查看 `第三章` Demo.

## 第四章 ##

本章使用了一些 复合的一些操作，用法，

#### 栅栏信号 ####

顾名思义，类似于 GCD 栅栏函数，特别适用于多个异步信号的处理，.

核心代码如下

```
  [self rac_liftSelector:@selector(updateUIWithOneData:TwoData:) withSignalsFromArray:@[signal1,signal2]];

```
其中 `signal1 ` 和 `signal2 ` 是两个异步信号，我们统一消息的接收 ,方法名 是 `- (void)updateUIWithOneData:(id )oneData TwoData:(id )twoData`. 需要注意的是方法的参数是和加入 `栅栏信号` 的异步信号是一一对应的。

#### 唯一信号(多订阅) ####

有的时候，需要多个不同UI甚至VC 接收同一数据，如果多次订阅，会导致发送信号多次，不符合我们的初衷，这个时候 需要一个  唯一信号处理。

关键代码是 

```
RACMulticastConnection *connection = [signal publish];
```

将我们的信号转化为 `订阅连接类的信号`,然后我们可以在我们的各个需要数据的类进行多次订阅

```
  [connection.signal subscribeNext:^(id  _Nullable x) {
    NSLog(@"A处在处理回调数据%@",x);
  }];
```


最后我们还需要进行连接 

```
[connection connect]
```
此时信号就会触发。 


#### 指令信号 ####

RACCommand 是 RAC 中的最复杂的一个类之一，它本身并不是一个 `RACStream` 或者 `RACSignal` 的子类，而是一个用于管理 RACSignal 的创建与订阅的类，它可以监听 RACCommand 自身的执行状态，比如开始、进行中、完成、错误等. 这个高级类我用的比较少，我们可以在 需要给信号传递参数的时候，使用 指令信号，你也可以百度去专门查询 该类的使用。后续再继续补充。

#### 绑定信号 ####

其实就是 信号的 `bind` 方法，对源信号的数据进行处理 再返回，比如对数据进行解析等，关键代码如下

```

  // 2. 绑定信号
  RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
    
    /*
    RACSignal * _Nullable (^RACSignalBindBlock)(ValueType _Nullable value, BOOL *stop);

     */
    return ^RACSignal *(id  value, BOOL *stop) {
      /* value 源信号发送的消息
       * 只要源信号发送数据，即可调用这个block
       */
      NSLog(@"%@",value);
      if ([value isKindOfClass:[NSString class]]) {
        value = @"操作数据";
      }
      return [RACReturnSignal return:value];
    };
  }];

```

好了，一些简单的 RAC 就到此为止了，我相信看了这个Demo，就算不知道 RAC原理，也应该能使用了。不过我们要做一个有追求的程序员，我们还是需要去网上搜索一些RAC原理去阅读，当然我的Demo里面也有一些断点，可以更好的去辅助了解整个RAC的信号订阅。
