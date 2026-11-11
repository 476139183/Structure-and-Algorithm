from solution import Solution
from solution import ListNode

def listnum(nums):
    """
    :type nums Array
    :rtype ListNode
    """
    l = ListNode(0)
    node = l

    for x in nums:
        node.next = ListNode(x)
        node = node.next
    
    return l.next

def assertEqual(l1, l2):
    """
    :type l1 ListNode
    :type l2 ListNode
    """
    while l1 != None and l2 != None:
        if l1.val != l2.val:
            break
        else:
            l1 = l1.next
            l2 = l2.next
    assert l1 == None and l2 == None

s = Solution()
assertEqual(s.addTwoNumbers(listnum([7, 8, 9]), listnum([0, 9, 3])), listnum([7, 7, 3, 1]))
assertEqual(s.addTwoNumbers(listnum([1]), listnum([9, 9, 9])), listnum([0, 0, 0, 1]))
