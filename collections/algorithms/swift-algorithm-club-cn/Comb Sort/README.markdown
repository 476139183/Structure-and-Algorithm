# Comb Sort
# 梳排序

A common issue for Bubble Sort is when small values are located near the end of an array. 
This problem severely slows down Bubble Sort, as it must move the small value -- or _turtle_ -- 
through nearly the entire array. Bubble Sort works by checking the current index of an array 
against the next index, and when those two values are unsorted, they are swapped into place. 
As a result, the values bubble into their rightful place within the array. 

冒泡排序的一个常见问题是当小值位于数组末尾附近时。
这个问题严重减慢了冒泡排序，因为它必须移动小值 - 或 _turtle_ -- 通过几乎整个数组。 冒泡排序的工作原理是检查数组的当前索引对于下一个索引，当这两个值未排序时，它们将被交换到位。结果，这些值冒泡到数组中的合法位置。

Comb Sort improves upon Bubble Sort by dealing with these turtles near the end of the array. 
The value of the current index of the array is compared against one a set distance away. This 
removes a worst-case scenario of Bubble Sort, and greatly improves on the time complexity of Bubble Sort.   
梳排序通过处理数组末端附近的这些turtles来改进冒泡排序。
将数组的当前索引的值与设定距离之一进行比较。 这个消除了冒泡排序的最坏情况，并大大提高了冒泡排序的时间复杂度。

## Example 
## 例子

A step-by-step example of how Comb Sort works, and differs from Bubble Sort, can be seen [here](http://www.exforsys.com/tutorials/c-algorithms/comb-sort.html). 
有关梳排序如何工作的分步示例，与冒泡排序不同，可以看[这里](http://www.exforsys.com/tutorials/c-algorithms/comb-sort.html)。

Here is a visual to see Comb Sort in effect: 
这是一个视觉效果，可以看到有效的梳子排序：

![](https://upload.wikimedia.org/wikipedia/commons/4/46/Comb_sort_demo.gif)

## Algorithm 
## 算法

Similar to Bubble Sort, two values within an array are compared. When the lower index value 
is larger than the higher index value, and thus out of place within the array, they are 
swapped. Unlike Bubble Sort, the value being compared against is a set distance away. This 
value -- the _gap_ -- is slowly decreased through iterations. 

与冒泡排序类似，比较数组中的两个值。 当指数值较低时它们大于较高的索引值，因此在数组中不合适，它们是交换。 与冒泡排序不同，要比较的值是设定的距离。 这个value - _gap_ - 通过迭代缓慢减少。

## The Code 
## 代码

Here is a Swift implementation of Comb Sort: 
这是一个Swift实现的梳子排序：


```swift
func combSort (input: [Int]) -> [Int] {
    var copy: [Int] = input
    var gap = copy.count
    let shrink = 1.3

    while gap > 1 {
        gap = (Int)(Double(gap) / shrink)
        if gap < 1 {
            gap = 1
        }
    
        var index = 0
        while !(index + gap >= copy.count) {
            if copy[index] > copy[index + gap] {
                swap(&copy[index], &copy[index + gap])
            }
            index += 1
        }
    }
    return copy
}
```

This code can be tested in a playground by calling this method with a paramaterized array to sort: 
可以通过使用参数化数组调用此方法来在playground中测试此代码以进行排序：

```swift
combSort(example_array_of_values)
```

This will sort the values of the array into ascending order -- increasing in value.  
这将按照升序对数组的值进行排序 - 增加值。

## Performance
## 性能

Comb Sort was created to improve upon the worst case time complexity of Bubble Sort. With Comb 
Sort, the worst case scenario for performance is exponential -- O(n^2). At best though, Comb Sort 
performs at O(n logn) time complexity. This creates a drastic improvement over Bubble Sort's performance. 

Similar to Bubble Sort, the space complexity for Comb Sort is constant -- O(1). 
This is extremely space efficient as it sorts the array in place. 

创建梳排序是为了改善冒泡排序的最坏情况时间复杂度。 随着梳子排序，性能的最坏情况是指数 - O(n^2)。 最好的是，梳子排序以O(n logn)时间复杂度执行。 这比冒泡排序的性能产生了巨大的改进。

与冒泡排序类似，梳子排序的空间复杂度是常数 - O(1)。
这是非常节省空间的，因为它对数组进行了原地排序。

## Additional Resources
## 补充资源

[梳排序的维基百科](https://en.wikipedia.org/wiki/Comb_sort)


*Written for the _Swift Algorithm Club_ by [Stephen Rutstein](https://github.com/srutstein21)*

*作者：[Stephen Rutstein](https://github.com/srutstein21)*   
*翻译：[Andy Ron](https://github.com/andyRon)*  
