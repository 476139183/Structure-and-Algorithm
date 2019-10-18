## 前沿 ##

[笔记WiKi](https://github.com/476139183/Structure-and-Algorithm/wiki)

#### 为什么我要学算法 ####

其实一开始就是为了应付面试，去了解算法，买了一本《算法导论》看，果不其然，，看到想哭，关键是还没学懂，只能无奈放弃。

时间如梭，转眼2019，偶然看到王争老师的[《数据结构与算法之美》](https://time.geekbang.org/column/article/39922),老师的豪言壮语，以及入门几篇的文章解读，学习算法之心逐渐涌现，也许是为了以后的面试，也许是为了扩展视野，我入手了这门课程。希望能真正的如王争老师所说，能迈过 **数据结构和算法分析** 这道坎，重新认识算法和数据结构。

#### 人们无法理解他没有经历过的事物 ####

最初的一个多月的学习，是真的不太顺利，很多东西没有吃透，没理解，专栏看的断断续续，陷入一个小困境，需要反复咀嚼篇文，但依然忘这忘那。不过所幸专栏已经让我看到了 算法的 门槛，学起来有目标。我后面就开始换一个学习方式，不再强求每一篇文章要求自己熟练，而是看一遍，尽量的看到最新的篇章之后，再回头看一遍，再攻读难点篇章。整体的阅读思考，局部的咀嚼，让自己形成有一个小小的算法思想。果然如老师所说 **"掌握了数据结构与算法，看待问题的深度，解决问题的角度就会完全不一样了"**    

至于这个专栏，我不要你觉得，我要我觉得：王争老师讲的的确好，也是真的带我入了算法门槛，至少能让我可以自主学习和理解数据结构和算法了，所以
后面附有邀请码，扫码购买更优惠哦（:joy:）


## 算法的由来 ##

> 最早出现在波斯数学家阿勒.花刺子密在公元825年所写的《印度数字算术》中。

#### 算法的定义       

 算法是解决特定问题求解步骤的描述，在计算机中表现为指令的有限序列，并且每一条指令表示一个或多个操作。 

#### 算法有5大基本特性

`输入`,`输出`,`有穷性`,`确定性`,`可行性`

##### 1.输入和输出 

算法具有0个或者多个输入，比如你输出 "Hello world",那就不需要输入，但是至少有一个输出，毕竟你不要输出，你用这个算法干嘛？ 

##### 2. 有穷性

指算法在执行有限步骤之后，自动结束而不会出现无限循环，并且每一个步骤在可接受的时间内完成。这个时间要实际合理，而不是说 需要20多年才能结束。

##### 3. 确定性

算法的每一步骤都具有确定的含义，不会出现二义性，算法的每个步骤被精确定义而无歧义

##### 4. 可行性

算法的每一步都必须是可行的，每一步都能通过执行有限次数完成，这意味着算法可以转换为程序在机器上运行并得到正确的结果。

#### 算法的设计要求

`正确性`，`可读性`，`健壮性`，`时间效率高和存储量低`

在设计一个算法的时候，需要满足起码的要求

1.正确性
  算法的正确性首先应当满足 算法的5大基本特性，上面已经提过了，而且在 `正确性` 上，由简入难，又分为四个层次:
  1. 算法程序没有语法错误
  2. 算法对于合法的输入数据能够产生满足要求的输出结果
  3. 算法对于非法的输入数据能够得出满足规格说明的结果
  4. 算法对于精心选择的，刁难的测试数据都有满足要求的输出结果

> 一般我们都选择 是否能到达层次3 作为一个算法是否正确的标准 

2. 可读性.        
   算法设计的另一个目的 是为了方便阅读 理解和交流，毕竟算法除了解决问题，还应担易于维护，和排查bug
    
3. 健壮性.     
   这个已经属于 层次3 的内容了，我们应当对输入的不合法的数据做出合适的处理，而不是产生异常，暴露弱点。
4. 时间效率高和存储量低.      
   我们的理想算法不就是 执行的时间最短，且需要的最大存储空间最低么。生活不也是这样么，当我们想去健身的时候，我们理想的选择 应该就是花最少的时间和努力，完成对肌肉的训练，也就是科学健身。那么制定完美的健身计划，对我们来说就是一个最优的算法，

## 大O复杂度表示法 ##

> 这是计算机前辈们，为了对算法的评估更科学，而研究出的事前分析估算法。也就是在计算机程序编制前，依据统计方法 用 “肉眼” 对算法的执行时间进行粗略估算。

我们了解算法基本的设计要求后，发现最后一个条件比较好进行量化操作，那么我们怎么知道设计好的算法的效率呢？时间和存储，我们一般优先关注时间效率，而通过大佬们的观察，我们发现一个程序在计算机运行的时间是取决于下面几个因素 ：       

1.`算法的策略和方法`      
2.`编译产生的代码质量`     
3. `问题的输入规模`      
4.`机器执行指令的速度`     

抛开软件与硬件相关的因素，我们发现，输入规模能够影响到算法的时间，如下代码

```
 int cal(int n) {
   int sum = 0;
   int i = 1;
   for (; i <= n; ++i) {
     sum = sum + i;
   }
   return sum;
 }

```

我们假设每一行代码 需要 1个 unit_time的执行时间，第4，5行执行了n遍，那么这段代码的总执行时间公式如下：      

T(n)=(2n+2)*unit_time

我们再看一段代码

```
 int cal(int n) {
   int sum = 0;
   int i = 1;
   int j = 1;
   for (; i <= n; ++i) {
     j = 1;
     for (; j <= n; ++j) {
       sum = sum +  i * j;
     }
   }
 }

```

我们同样去分析： 第 2、3、4 行代码，每行都需要 1 个 unit_time 的执行时间，第 5、6 行代码循环执行了 n 遍，需要 2n * unit_time 的执行时间，第 7、8 行代码循环执行了 n2遍，所以需要 2n2 * unit_time 的执行时间。所以，整段代码总的执行时间 T(n) = (2n2+2n+3)*unit_time。


我们可以看到，代码总执行的时间 T(n) 与 输入的 n 有关系，确切的来说 那就是 
<font color="darkOrange">所有代码的执行时间 T(n) 与每行代码的执行次数 n 成正比</font>

![趋势图](/Images/趋势图.png)


于是我们总结出一个公式:

![](/Images/大O表示法.png)

这就是 大O时间复杂度表示法，它代表着 代码执行的时间随着数据规模增长的变化趋势，也称之为“渐进时间复杂度”

在 大O时间复杂度表示法 中，我们只关注 程序执行时间与 数据规模之间的关系，而忽略一些低阶、常量、系数 。而且只记录一个最大量级的部分。

也就是前面两段代码的时间复杂度，记为：T(n) = O(n)； T(n) = O(n2)。


## 推导 大O 时间复杂度 ##

前面已经有介绍 大O 时间复杂度的由来和表示，下面开始进行分析和推导

1. 只关注循环执行次数最到的一段代码
   大 O 这种复杂度表示方法 只是表示与 数据规模 n 的变化趋势，所以只记录最大阶的量级，并且要忽略公式中的 常量、低阶、系数，所以 **我们在分析一个算法、一段代码的时间复杂度的时候，也只关注循环执行次数最多的哪一段代码就可以了** 

2. 加法法则：总复杂度等于量级最大的那段代码的复杂度

3. 乘法法则：嵌套代码的复杂度等于嵌套内外代码复杂度的乘积

这么来看，还是不够清晰，那么再看看《大话数据结构》给我们的攻略吧

1. 用常数1取代运行时间中所有的加法常数
2. 在修改后的运行次数函数中，只保留最高阶项
3. 如果最高阶项存在且不是1，则去除与这个项相乘的常数

这里有一个常见的时间复杂度表，方便我们自己推导和理解

![复杂度表](/Images/复杂度表.png)

> 多去分析,和运用，就能很快的理解这个推导法了

## 复杂度分析 ##

事实上，代码的逻辑并不单纯，也会有很多条件束缚，导致无法直接推导时间复杂度，如下代码所示：

```
// n 表示数组 array 的长度
int find(int[] array, int n, int x) {
  int i = 0;
  int pos = -1;
  for (; i < n; ++i) {
    if (array[i] == x) {
       pos = i;
       break;
    }
  }
  return pos;
}

```

可以看到，如果查找的元素正好是第一个，那么时间复杂度就是O(1),而如果数组不存在变量x，那么会将整个数组都遍历一遍，时间复杂度就变成了O(n),也是就说在不同情况下，代码的时间复杂度不一样。

其实在复杂度方面，有几个不同的名词，

1. __最好情况时间复杂度__    
   在最理想的情况下，执行这段代码的时间复杂度，如上所说的第一种情况
2. __最坏情况时间复杂度__.   
   在最糟糕的情况下，执行这段代码的时间复杂度，其实这是我们算法对运行时间的一个保证。在应用中，这是一种比较重要的需求，表示运行时间将不会再坏了         
3. __平均情况时间复杂度__.      
   这是最有意义的一种情况，因为它是期望的运行时间，代表着所有情况的平均时间，比如上面的例子，我们要查找的变量x在数组的位置，有n+1种情况：**在数组0～n-1中和不在数组中**。那么通过每一种情况的运行次数累加，再除以n-1，得到平均时间复杂度，即：
                 
  ![平均复杂度](/Images/平均复杂度.png)  
      
  通过大O表示法，得到平均时间复杂度就是O(n)。                   
  
  再接着上面的例子，我们这是假设所有的概率发生时一致的，但是实际上，n+1中情况，出现的概率并未完全一样，首先我们假设在数组中和不在数组中的概率都是1/2。另外，查找的数据在0~n-1中的概率是一样的，为1/n,那么通过概率乘法法则，要查找的数据出现在0～n-1的任意位置的概率其实是1/(2n)。那么我们通过每一种情况的概率考虑进去，那么平均时间复杂度计算变成了下面这样.               
     
  ![加权平均复杂度](/Images/加权平均复杂度.png)   
      
  这个值就是概率论中的 **`加权平均值`** ,也叫 **期望值** ,所以平均时间复杂度的全称应该叫 **加权平均时间复杂度** 或者 **期望时间复杂度** .
  
   
4. __均摊时间复杂度__
  这是一个更加高级的概念，是一种特殊的平均时间复杂度，应用场景也更加特殊和有限，需要的是多个操作之间有一定的前后时序关系，这样才能把耗时多的操作均摊到耗时少的操作，还涉及到 **摊还分析法**,有兴趣的应该去专栏专门去学习理解。

#### 总结 ####
  一般情况下，没特殊说明，我们都是指最坏时间复杂度，而很多时候，一段代码，在不同输入情况，复杂度量级有可能不一样，又或者复杂度量级一样，所以最好，最坏以及平均时间复杂度都是很好的帮组我们，让我们更加全面的去表示和分析一段代码的执行效率。
> 

## 后记 ##

最淡的墨水也胜于最强的记忆。学完之后，也总结一下，加深自己的印象和理解。

另外推荐两个顶尖学校的算法课程：

第一个是[MIT的算法导论公开课](http://open.163.com/special/opencourse/algorithms.html)，网易公开课有中文字幕。

第二个是[普林斯顿大学的算法课程](https://www.bilibili.com/video/av8994940)，可以在B站免费观看

当然还有我的邀请码，毕竟笔记肯定没有老师讲的好

![邀请码](/Images/WechatCode.jpeg)

我的[文章链接](https://476139183.github.io)
