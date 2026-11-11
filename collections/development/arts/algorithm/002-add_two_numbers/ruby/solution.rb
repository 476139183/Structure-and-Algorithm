class ListNode
    attr_accessor :val, :next
    def initialize(val)
        @val = val
        @next = nil
    end
end

# @param {ListNode} l1
# @param {ListNode} l2
# @return {ListNode}
def add_two_numbers(l1, l2)
    sum = ListNode.new(0)
    head = sum
    carry = 0

    while l1 || l2 || carry > 0
      if l1 
        sum.val += l1.val
        l1 = l1.next
      end

      if l2
        sum.val += l2.val
        l2 = l2.next
      end

      sum.val += carry
      carry = sum.val / 10
      sum.val %= 10

      if l1 || l2 || carry > 0
        sum.next = ListNode.new(0)
        sum = sum.next
      end
    end

    return head
end