.global _start

.section .text
_start:
 movq num,%rax
 xor %rdx,%rdx

Loop_HW1:
 shr $1,%rax
 jae Case_HW1
 incl %edx

Case_HW1:
 test %rax,%rax
 jnz Loop_HW1
 
movl %edx,CountBits

end_HW1:
    
