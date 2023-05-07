.global _start

.section .text
_start:


xor %r8d,%r8d  #r8d=i for array1
xor %r9d,%r9d  #r9d=j for array2
xor %r10d,%r10d #r10d=k for merged
xor %r11,%r11



Loop_HW1:
movl array1(,%r8d,4),%r15d #r15=array1[i]
movl array2(,%r9d,4),%r14d #r14=array2[j]
testl %r15d,%r15d
jz completeArray2_HW1
testl %r14d,%r14d
jz completeArray1_HW1

cmpl %r14d,%r15d
jae addArray1_HW1

cmpl %r14d,%r11d
je Case2_HW1
movl %r14d,mergedArray(,%r10d,4)
movl %r14d,%r11d
inc %r10d
Case2_HW1:
inc %r9d
jmp Loop_HW1

addArray1_HW1:
cmpl %r15d,%r11d
je Case1_HW1
movl %r15d,mergedArray(,%r10d,4)
movl %r15d,%r11d
inc %r10d
Case1_HW1:
inc %r8d
jmp Loop_HW1



completeArray1_HW1:
testl %r15d,%r15d
jz End_HW1
cmpl %r15d,%r11d
je Skip1_HW1
movl %r15d,mergedArray(,%r10d,4)
movl %r15d,%r11d
inc %r10d
Skip1_HW1:
inc %r8d
movl array1(,%r8d,4),%r15d #r15=array1[i]
jmp completeArray1_HW1

completeArray2_HW1:
testl %r14d,%r14d
jz End_HW1
cmpl %r14d,%r11d
je Skip2_HW1
movl %r14d,mergedArray(,%r10d,4)
movl %r14d,%r11d
inc %r10d
Skip2_HW1:
inc %r9d
movl array2(,%r9d,4),%r14d #r14=array2[j]
jmp completeArray2_HW1


End_HW1:
movl $0,mergedArray(,%r10d,4)




