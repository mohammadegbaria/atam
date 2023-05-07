.global _start

.section .text
_start:
   xor %rax, %rax
   xor %rbx, %rbx
   xor %rcx,%rcx
   xor %rdx, %rdx
   movswq (num), %rcx
   cmp $0, %ecx
   js negative_HW1
   je end_HW1
   mov $source, %rbx
   mov $destination, %rax
   jmp condition_HW1
   
negative_HW1:
   mov $destination, %rbx
   mov $source, %rax
   not %rcx
   inc %rcx
   
condition_HW1:
   xor %r9, %r9
   xor %r10, %r10
   add %rax ,%r10
   sub %rbx, %r10
   cmp $0, %r10
   jl less_HW1
   cmp %rcx , %r10
   js backward_HW1
   jmp forward_HW1
   
   
less_HW1:   
   xor %r10, %r10
   sub %rax, %r10
   add %rbx ,%r10
   cmp %rcx , %r10
   js forward_HW1
   
          
forward_HW1:
   movb (%rbx,%r9,1) , %dl
   movb %dl, (%rax,%r9,1)
   inc %r9
   cmp %r9, %rcx
   jg forward_HW1
   jmp end_HW1
   
backward_HW1:
   dec %rcx
   movb (%rbx,%rcx,1), %dl
   movb %dl, (%rax,%rcx,1)
   jnz backward_HW1
   
   
end_HW1:
         