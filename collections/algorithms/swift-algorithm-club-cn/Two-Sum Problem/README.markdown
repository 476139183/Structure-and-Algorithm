# Two-Sum Problem

Given an array of integers and an integer target, return the indices of two numbers that add up to the target.

There are a variety of solutions to this problem (some better than others). The following solutions both run in **O(n)** time.

给定一个整数数组和一个整数目标，返回与目标相加的两个数字的索引。

这个问题有很多解决方案（有些比其他解决方案更好）。 以下解决方案均在**O(n)**时间内运行。

# Solution 1
# 解决方案1

This solution looks at one number at a time, storing each number in the dictionary. It uses the number as the key and the number's index in the array as the value.

For each number n, we know the complementing number to sum up to the target is `target - n`. By looking up the complement in the dictionary, we'd know whether we've seen the complement before and what its index is.

此解决方案一次查看一个数字，将每个数字存储在字典中。 它使用数字作为键，数组中的数字索引作为值。

对于每个数字n，我们知道总和到目标的互补数是 `target - n`。 通过在字典中查找补语，我们可以知道我们是否已经看过补码之前及其索引是什么。

```swift
func twoSum(_ nums: [Int], target: Int) -> (Int, Int)? {
    var dict = [Int: Int]()
    
    // For every number n,
    for (currentIndex, n) in nums.enumerated() {
        // Find the complement to n that would sum up to the target.
        let complement = target - n
        
        // Check if the complement is in the dictionary.
        if let complementIndex = dict[complement] {
            return (complementIndex, currentIndex)
        }
        
        // Store n and its index into the dictionary.
        dict[n] = currentIndex
    }
    
    return nil
}
```

The `twoSum` function takes two parameters: the `numbers` array and the target sum. It returns the two indicies of the pair of elements that sums up to the target, or `nil` if they can't be found.

Let's run through the algorithm to see how it works. Given the array:

`twoSum`函数有两个参数：`numbers`数组和目标和。 它返回总和到目标的元素对的两个指标，如果找不到则返回`nil`。

让我们通过算法来看看它是如何工作的。 给定数组：

```swift
[3, 2, 9, 8]
```

Let's find out if there exist two entries whose sum is 10.

Initially, our dictionary is empty. We begin looping through each element:

让我们看看是否存在两个总和为10的条目。

最初，我们的字典是空的。 我们开始循环遍历每个元素：

- **currentIndex = 0** | n = nums[0] = 3 | complement = 10 - 3 = 7

Is the complement `7` in the dictionary? No, so we add `3` and its index `0` to the dictionary.
字典中的补码是`7`吗？ 不，所以我们将`3`及其索引`0`添加到字典中。

```swift
[3: 0]
```

- **currentIndex = 1** | n = 2 | complement = 10 - 2 = 8

Is the complement `8` in the dictionary? No, so we add `2` and its index `1` to the dictionary.
字典中的补码是`8`吗？ 不，所以我们将`2`及其索引`1`添加到字典中。

```swift
[3: 0, 2: 1]
```

- **currentIndex = 2** | n = 9 | complement = 10 - 9 = 1

Is the complement `1` in the dictionary? No, so we add `9` and its index `2` to the dictionary.:
字典中的补码是`1`吗？ 不，所以我们将`9`及其索引`2`添加到字典中：

```swift
[3: 0, 2: 1, 9: 2]
```

- **currentIndex = 3** | n = 8 | complement = 10 - 8 = 2

Is the complement `2` in the dictionary? Yes! That means that we have found a pair of entries that sum to the target!

Therefore, the `complementIndex = dict[2] = 1` and the `currentIndex = 3`. The tuple we return is `(1, 3)`.

If the given array has multiple solutions, only the first solution is returned.

The running time of this algorithm is **O(n)** because it may look at every element in the array. It also requires **O(n)** additional storage space for the dictionary.

字典中的补码是`2`吗？ 是! 这意味着我们找到了一对与目标相加的条目！

因此，`complementIndex = dict[2] = 1`和`currentIndex = 3`。 我们返回的元组是`(1, 3)`。

如果给定的数组有多个解决方案，则只返回第一个解决方案。

该算法的运行时间为**O(n)**，因为它可能会查看数组中的每个元素。 它还需要**O(n)**字典的额外存储空间。

# Solution 2
# 解决方案2

**Note**: This particular algorithm requires that the array is sorted, so if the array isn't sorted yet (usually it won't be), you need to sort it first. The time complexity of the algorithm itself is **O(n)** and, unlike the previous solution, it does not require extra storage. Of course, if you have to sort first, the total time complexity becomes **O(n log n)**. Slightly worse but still quite acceptable.

Here is the code in Swift:

**注意**：这个特殊的算法要求对数组进行排序，因此如果数组尚未排序（通常不会排序），则需要先对其进行排序。 算法本身的时间复杂度为**O(n)**，与之前的解决方案不同，它不需要额外的存储空间。 当然，如果你必须先排序，总时间复杂度变为**O(n log n)**。 稍差但仍然可以接受。

这是Swift中的代码：


```swift
func twoSumProblem(_ a: [Int], k: Int) -> ((Int, Int))? {
  var i = 0
  var j = a.count - 1

  while i < j {
    let sum = a[i] + a[j]
    if sum == k {
      return (i, j)
    } else if sum < k {
      i += 1
    } else {
      j -= 1
    }
  }
  return nil
}
```

As in the first solution, the `twoSumProblem()` function takes as parameters the array `a` with the numbers and `k`, the sum we're looking for. If there are two numbers that add up to `k`, the function returns a tuple containing their array indices. If not, it returns `nil`. The main difference is that `a` is assumed to be sorted.

To test it, copy the code into a playground and add the following:

与第一个解决方案一样，`twoSumProblem()`函数将数组`a`作为参数，使用数字和`k`，我们正在寻找的总和。 如果有两个数字加起来为`k`，则该函数返回一个包含其数组索引的元组。 如果没有，则返回`nil`。 主要区别在于假定`a`被排序。

要测试它，请将代码复制到游乐场并添加以下内容：


```swift
let a = [2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100]
if let (i, j) = twoSumProblem(a, k: 33) {
  a[i] + a[j]  // 33
}
```

This returns the tuple `(8, 10)` because `a[8] = 12` and `a[10] = 21`, and together they add up to `33`.

So how does this algorithm work? It takes advantage of the array being sorted. That's true for many algorithms, by the way. If you first sort the data, it's often easier to perform your calculations.

In the example, the sorted array is:

这将返回元组`(8, 10)`因为`a[8] = 12`和`a[10] = 21`，它们一起加起来为`33`。

那么这个算法是如何工作的呢？ 它利用了正在排序的数组。 顺便说一下，许多算法都是如此。 如果您首先对数据进行排序，则通常更容易执行计算。

在示例中，排序的数组是：


	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]

The algorithm uses the two variables `i` and `j` to point to the beginning and end of the array, respectively. Then it increments `i` and decrements `j` until the two meet. While it's doing this, it checks whether `a[i]` and `a[j]` add up to `k`.

Let's step through this. Initially, we have:

该算法使用两个变量`i`和`j`分别指向数组的开头和结尾。 然后它增加`i`并递减`j`直到两者相遇。 当它这样做时，它会检查`a[i]`和`a[j]`是否加起来为`k`。

让我们一步一步。 最初，我们有：

	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]
      i                                        j

The sum of these two is `2 + 100 = 102`. That's obviously too much, since `k = 33` in this example. There is no way that `100` will ever be part of the answer, so decrement `j`.

We have:

这两者的总和是`2 + 100 = 102`。 这显然太多了，因为在这个例子中`k = 33`。 `100`永远不会成为答案的一部分，所以减少`j`。

我们有：

	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]
      i                                    j

The sum is `2 + 22 = 24`. Now the sum is too small. We can safely conclude at this point that the number `2` will never be part of the answer. The largest number on the right is `22`, so we at least need `11` on the left to make `33`. Anything less than `11` is not going to cut it. (This is why we sorted the array!)

So, `2` is out and we increment `i` to look at the next small number.

总和是`2 + 22 = 24`。 现在总和太小了。 我们可以在这一点上得出结论，数字`2`永远不会成为答案的一部分。 右边最大的数字是`22`，所以我们至少需要左边的`11`来制作`33`。 任何低于`11`的东西都不会削减它。 （这就是我们对数组进行排序的原因！）

所以，`2`出来了，我们增加`i`来看下一个小数字。

	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]
         i                                 j

The sum is `3 + 22 = 25`. Still too small, so increment `i` again.
总和是`3 + 22 = 25`。 还是太小了，所以再次增加`i`。

	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]
            i                              j

In fact, we have to increment `i` a few more times, until we get to `12`:
事实上，我们必须再增加几次`i`，直到我们达到`12`：

	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]
                               i           j

Now the sum is `12 + 22 = 34`. It's too high, which means we need to decrement `j`. This gives:
现在总和是`12 + 22 = 34`。 它太高了，这意味着我们需要减少`j`。 这给出了：

	[ 2, 3, 4, 4, 7, 8, 9, 10, 12, 14, 21, 22, 100 ]
                               i       j

And finally, we have the answer: `12 + 21 = 33`. Yay!

It's possible, of course, that there are no values for `a[i] + a[j]` that sum to `k`. In that case, eventually `i` and `j` will point at the same number. Then we can conclude that no answer exists and we return `nil`.

I'm quite enamored by this little algorithm. It shows that with some basic preprocessing on the input data -- sorting it from low to high -- you can turn a tricky problem into a very simple and beautiful algorithm.

最后，我们得到了答案：`12 + 21 = 33`。 好极了！

当然，有可能`a[i] + a[j]`没有与”k“相加的值。 在这种情况下，最终`i`和`j`将指向相同的数字。 然后我们可以得出结论，没有答案存在，我们返回`nil`。

我非常迷恋这个小算法。 它表明，对输入数据进行一些基本的预处理 - 从低到高排序 - 你可以把一个棘手的问题变成一个非常简单和漂亮的算法。

## Additional Reading
## 等多阅读

* [3Sum / 4Sum](https://github.com/raywenderlich/swift-algorithm-club/tree/master/3Sum%20and%204Sum)

*Written for Swift Algorithm Club by Matthijs Hollemans and Daniel Speiser*

*作者：Matthijs Hollemans， Daniel Speiser*  
*翻译：[Andy Ron](https://github.com/andyRon)*
