.global _start

.section .text
_start:
    # write your code here
    movq root ,%rax
    cmp $0 ,%rax
    je empty_HW1
    movq $new_node ,%rbx
    movq (%rbx) ,%rdx
    
current_HW1: 
    cmpq (%rax) ,%rdx
    je end_HW1
    movq %rax ,%r9
    js left_son_HW1
    jmp right_son_HW1
       
left_son_HW1:
    movq 8(%rax) ,%rax
    cmp $0 ,%rax
    jne current_HW1
    movq $new_node ,8(%r9)
    jmp end_HW1
    
right_son_HW1:
    movq 16(%rax) ,%rax
    cmp $0 ,%rax
    jne current_HW1
    movq $new_node ,16(%r9)
    jmp end_HW1  
      
empty_HW1:
    movq $new_node , root
    
end_HW1:    
