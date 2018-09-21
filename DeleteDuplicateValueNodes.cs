/*
You're given the pointer to the head node of a sorted linked list, where the data in the nodes is in ascending order.
Delete as few nodes as possible so that the list does not contain any value more than once. 
The given head pointer may be null indicating that the list is empty.
*/

/* Return head od linked list 


/*
* For your reference:
*
* SinglyLinkedListNode {
*     int data;
*     SinglyLinkedListNode next;
* }
*/

    static SinglyLinkedListNode removeDuplicates(SinglyLinkedListNode head) {
        SinglyLinkedListNode current = head;
        
        if (head == null)
            return null;
        
        int valueOfNode = current.data;
        
        while(current.next != null)
        {
            if (current.next.data == valueOfNode)
            {
                SinglyLinkedListNode nextCurr = current.next;
                if(nextCurr.next == null)
                    current.next = null;
                else
                    current.next = nextCurr.next;
            }
            else
            {
                current = current.next;
                valueOfNode = current.data;
            }
                
        }
        
        return head;

    }
