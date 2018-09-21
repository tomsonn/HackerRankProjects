/*
 You’re given the pointer to the head node of a linked list and a specific position. 
 Counting backwards from the tail node of the linked list, get the value of the node at the given position. 
 A position of 0 corresponds to the tail, 1 corresponds to the node before the tail and so on.
 
 In this file we dont read anything from Console, everything is passed
*/

/*
* For your reference:
*
* SinglyLinkedListNode {
*     int data;
*     SinglyLinkedListNode next;
* }
*
*/
    static int numberOfNodes(SinglyLinkedListNode head)
    {
        SinglyLinkedListNode current = head;
        int numberOfNodes = 1;
        
        while(current.next != null)
        {
            current = current.next;
            numberOfNodes++;
        }     
        
        return numberOfNodes;
    }

    static int getNode(SinglyLinkedListNode head, int positionFromTail) {
        
        SinglyLinkedListNode current = head;
        int positionFromHead = numberOfNodes(head) - positionFromTail;
        int couting = 1;
        
        while(couting < positionFromHead)  
        {
            current = current.next;
            couting++;
        }
        
        return current.data;
    }
