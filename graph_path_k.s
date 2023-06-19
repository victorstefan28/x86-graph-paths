.data
n: .space 4
c: .space 4
scanf_f: .asciz "%d\n"
printf_new: .asciz "%d\n"
printf_f: .asciz "%d "
print_mat_lin: .asciz "%d"
newlin: .asciz "\n"
matrix: .space 400
mataux: .space 400
i: .space 4
ct: .space 4
j: .space 4
x: .space 4
leg: .space 80
lng: .space 4
ns: .space 4
nd: .space 4
matrez: .space 400

.text

matrix_mult:
	
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl %edi
pushl %ebx


// ebp+8 m1
// ebp+12 m2
// ebp+16 mres
// ebp+20 n
// var locale-> ebp - 16
subl $44, %esp 
movl $0, -16(%ebp)
movl $0, -20(%ebp)
movl $0, -24(%ebp)
// 
// ebp - 16= i -> -16
// ebp - 20= j -> -20
// ebp - 24 = k -> -24
// ebp - 28 = left -> -28
// ebp - 32 = right -> -32
// ebp - 36 = index i j -> -36
// ebp - 40 = index i k -> -40
// ebp - 44 = index k j -> -44
// ebp - 48 = rez -> -48

movl 20(%ebp), %eax
mull 20(%ebp)
movl %eax, -52(%ebp)

movl $0, %ecx
movl 16(%ebp), %esi
lea 0(%esi), %edi
setzero:
movl $0, (%edi, %ecx, 4)
incl %ecx
cmp %ecx, -52(%ebp)
jne setzero



loop1:
	movl $0, -20(%ebp)
	loop2:
		movl $0, -24(%ebp)
		loop3:
			
			
			movl -16(%ebp), %eax
			movl $0, %edx
			mull 20(%ebp)
			addl -20(%ebp), %eax
			movl %eax, -36(%ebp)
			
			movl -16(%ebp), %eax
			movl $0, %edx
			mull 20(%ebp)
			addl -24(%ebp), %eax
			movl %eax, -40(%ebp)
			
		
			movl -24(%ebp), %eax
			movl $0, %edx
			mull 20(%ebp)
			addl -20(%ebp), %eax
		
			movl %eax, -44(%ebp)
			movl 8(%ebp), %esi
			lea 0(%esi), %edi
			movl -40(%ebp), %edx
			movl (%edi, %edx, 4), %eax
		
			
		
			movl -44(%ebp), %edx
			movl 12(%ebp), %esi
			lea 0(%esi), %edi
			movl (%edi, %edx, 4), %ebx
			movl $0, %edx
			mull %ebx
			movl %eax, -48(%ebp)
			
			
			movl -36(%ebp), %edx
			movl 16(%ebp), %esi
			lea 0(%esi), %edi
			movl (%edi, %edx, 4), %eax
			addl -48(%ebp), %eax
			movl %eax, (%edi, %edx, 4)
			
			
			addl $1, -24(%ebp)
			movl -24(%ebp), %ecx
			cmp %ecx, 20(%ebp)
			jne loop3
			
			
		
		addl $1, -20(%ebp)
		movl -20(%ebp), %ecx
		cmp 20(%ebp), %ecx
		jne loop2
		
	
	addl $1, -16(%ebp)
	movl -16(%ebp), %ecx
	cmp %ecx, 20(%ebp)
	jne loop1

addl $44, %esp
popl %ebx
popl %edi
popl %esi
popl %ebp
	
ret

.globl main
main:

pushl $c
pushl $scanf_f
call scanf
popl %ebx
popl %ebx

pushl $n
pushl $scanf_f
call scanf
popl %ebx
popl %ebx




movl $0, i
for_leg:
movl i, %ecx

pushl $x
pushl $scanf_f
call scanf
popl %ebx
popl %ebx

incl i
movl i, %ecx
movl x, %ebx
lea leg, %edi
movl %ebx, (%edi, %ecx, 4)

cmp %ecx, n
jne for_leg



movl $0, i
movl i, %ecx

et_for_nod:
lea leg, %edi

movl 4(%edi, %ecx, 4), %edx
movl %edx, ct
cmp $0, %edx
je continue

movl $0, j
	et_for_muchii:
	pushl $x
	pushl $scanf_f
	call scanf
	popl %ebx
	popl %ebx
	lea matrix, %edi
	
	movl i, %eax
	movl $0, %edx
	mull n
	addl x, %eax
	
	movl $1, (%edi, %eax, 4)
	lea matrez, %edi
	movl $1, (%edi, %eax, 4)
	lea mataux, %edi
	movl $1, (%edi, %eax, 4)
	
	incl j
	movl j, %edx
	
	cmp %edx, ct
	jne et_for_muchii
	
continue:
incl i
movl i, %ecx

cmp %ecx, n
jne et_for_nod

movl c, %eax
cmp $1, %eax
je cerinta1
cmp $2, %eax
je cerinta2
cmp $3, %eax
jge et_exit

cerinta1:
jmp et_afis_mat


jmp et_exit

cerinta2:

pushl $lng
pushl $scanf_f
call scanf
popl %ebx
popl %ebx

pushl $ns
pushl $scanf_f
call scanf
popl %ebx
popl %ebx

pushl $nd
pushl $scanf_f
call scanf
popl %ebx
popl %ebx

movl $1, i
movl i, %ecx

cmp %ecx, lng
je sari

for_apel:

pushl n
pushl $matrez
pushl $mataux
pushl $matrix
call matrix_mult
popl %ebx
popl %ebx
popl %ebx
popl %ebx
movl n, %eax
movl $0, %edx
mull n
movl $4, %ecx
mull %ecx
movl %eax, j

pushl j
pushl $matrez
pushl $matrix
call memcpy
popl %ebx
popl %ebx
popl %ebx

incl i
movl i, %ecx
cmp %ecx, lng
jg for_apel

sari:

movl $0, ct

lea matrez, %edi
mov ns, %eax
mull n
addl nd, %eax
movl (%edi, %eax, 4), %ebx
movl %ebx, ct
pushl ct
pushl $printf_new
call printf
popl %ebx
popl %ebx
pushl $0
call fflush
popl %ebx
jmp et_exit

cerinta3:


et_afis_mat:
movl $0, i
	for_lin:
	movl i, %ecx
	cmp %ecx, n
	je et_exit
	movl $0, j
		for_col:
		movl j, %ecx
		cmp %ecx, n
		je cont
		movl i, %eax
		movl $0, %edx
		mull n
		addl j, %eax
		lea matrix, %edi
		movl (%edi, %eax, 4), %ebx
		pushl %ebx
		pushl $printf_f
		call printf
		popl %ebx
		popl %ebx
		
		pushl $0
		call fflush
		popl %ebx
		
		incl j
		jmp for_col
	
	
	cont:
	movl $4, %eax
	movl $1, %ebx
	movl $newlin, %ecx
	movl $1, %edx
	int $0x80
	
	incl i
	jmp for_lin
	
et_exit:
mov $1, %eax
mov $0, %ebx
int $0x80

