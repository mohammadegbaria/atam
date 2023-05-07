.global _start

.section .text
_start:

movq src,%r12 #r12=src
movq dst,%r13 #r13=dst
xor %r8d,%r8d #counter for src
xor %r9d,%r9d #counter for dst
cmpq %r12,%r13
je End_HW1

movq head(%rip),%rax #rax=head rax iterator
testq %rax,%rax
je End_HW1

#End if duplicates were found
FindDuplicates_HW1:
movq (%rax),%r11
cmp %r11,%r12
jne checkDst_HW1
inc %r8d
checkDst_HW1:
cmp %r11,%r13
jne continue_HW1
inc %r9d
continue_HW1:
movq 8(%rax),%rax
testq %rax,%rax
jz endSearch_HW1
jmp FindDuplicates_HW1

endSearch_HW1:
cmp $1,%r8d 
jne End_HW1
cmp $1,%r9d
jne End_HW1

xor %rax,%rax
movq head(%rip),%r10 #r10=head for src
movq head(%rip),%r11 #r11=head for dst
xor %r14,%r14 #src index
xor %r15,%r15 #dst index
movq head(%rip),%rcx #rcx=src.prev
movq head(%rip),%rbx #rbx=dst.prev


FindSrc_HW1:
cmp (%r10),%r12 # if(r10->data==src)
je FindDst_HW1
inc %r14d
movq %r10,%rcx
movq 8(%r10),%r10
testq %r10,%r10
jz End_HW1
jmp FindSrc_HW1


FindDst_HW1:
cmpq (%r11),%r13
je AreNeighbors_HW1
inc %r15d
movq %r11,%rbx
movq 8(%r11),%r11
testq %r11,%r11
jz End_HW1
jmp FindDst_HW1


AreNeighbors_HW1:
cmpq %r14,%r15 # check A=B
je End_HW1
cmpq 8(%r10), %r11 # A->next=B
je SrcThenDst_HW1
cmpq 8(%r11), %r10 # B->next=A
je  DstThenSrc_HW1
jmp NotNeighbors_HW1 

SrcThenDst_HW1:
cmp $0, %r14 # A==head, src in head
je SrcHeadCase1_HW1
movq %r11,8(%rcx) #A.prev->next=B
jmp SrcNotHead1_HW1
SrcHeadCase1_HW1:
movq %r11,head #head=B
SrcNotHead1_HW1: 
movq 8(%r11), %rax # tmp=B->Next
movq %rax, 8(%r10) # A->Next=B=>Next
movq %r10, 8(%r11) # B->Next=A
jmp End_HW1 

DstThenSrc_HW1:
cmp $0, %r15 # B==head, dst in head
je DstHeadCase1_HW1
movq %r10,8(%rbx) #B.prev->Next = A
jmp DstNotHead1_HW1
DstHeadCase1_HW1:
mov %r10,head # Head=A
DstNotHead1_HW1:
movq 8(%r10), %rax #tmp=A->Next
movq %rax, 8(%r11) #B->Next=A->Next
movq %r11, 8(%r10) #A->Next=B
jmp End_HW1

NotNeighbors_HW1 :
cmp $0, %r14 #A==head?
je SrcHeadCase2_HW1
cmp $0, %r15 #B==head?
je DstHeadCase2_HW1
movq %r10, 8(%rbx) #B.prev->Next = A
movq %r11, 8(%rcx)  #A.prev->Next = B
jmp Finish_HW1

SrcHeadCase2_HW1: #A=head
movq %r11,head #head=B
movq %r10, 8(%rbx) #B.prev->Next = A
jmp Finish_HW1

DstHeadCase2_HW1: #B=head
movq %r10,head #head=A
movq %r11, 8(%rcx)  #A.prev->Next = B


Finish_HW1:
movq 8(%r11), %r15   #tmp1=B->Next
movq 8(%r10), %r14   #tmp2=A->Next
movq %r15, 8(%r10)   #A->Next=B->Next
movq %r14, 8(%r11)   #B->Next =A->Next

End_HW1:









