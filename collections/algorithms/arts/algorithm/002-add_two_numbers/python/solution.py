class ListNode(object):
    def __init__(self, x):
        self.val = x
        self.next = None

class Solution(object):
    def addTwoNumbers(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        sum = ListNode(0)
        head = sum
        carry = 0

        while True:
            if l1 != None:
                sum.val += l1.val
                l1 = l1.next

            if l2 != None:
                sum.val += l2.val
                l2 = l2.next

            sum.val += carry
            carry = sum.val / 10
            sum.val %= 10

            if l1 != None or l2 != None or carry > 0:
                sum.next = ListNode(0)
                sum = sum.next
            else:
                break
        
        return head