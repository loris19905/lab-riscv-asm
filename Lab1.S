.data
N:
.word 6
M:
.word 6

array:
.word 1, 1, 1, 1, 1, 1
.word 2, 2, 2, 2, 2, 2
.word 3, 3, 3, 3, 3, 3
.word 4, 4, 4, 4, 4, 4
.word 6, 6, 6, 6, 6, 6
.word 5, 5, 5, 5, 5, 5


result:		#переменная, от которой отсчитываем минимальную сумму
.word 0

index:		#переменная для номера строки с минимальной суммой
.word 0

.text

main:

####Загрузка адресов переменных#####
la a2, N		
la a3, M		
la a4, array
la a5, result
####################################

## точка вызова функции#############
call process
####################################

la a2, index 	  #a2 = @index
call print
call exit

print:
addi a0, x0, 1    # print_int ecall
lw a1, 0(a2)
ecall
ret

exit:
addi a0, x0, 10
ecall

process:

lw t1, 0(a2)      	# t1 = N
lw t2, 0(a3)      	# t2 = M
lw a6, 0(a5)      	# a6 = @result
la a7, index      	# a7 = @index

addi t4, x0, 0      # j = 0; t4 = i

init:
addi t5, x0, 0    	# t5 - для подсчета суммы строки
addi t3, x0, 0    	# i = 0; t3 = i

cycle:
lw t6, 0(a4)      	# t6 = array[i][j]
addi a4, a4, 4    	# (по факту смещение указателя на 4 байта)
add t5, t5, t6    	# t5 += t6
addi t3, t3, 1    	# i++
blt t3, t1, cycle 	# (i < N) ? (ниже по строкам) : (-> cycle:)

blt t5, a6, default # (t5 < a6) ? (-> default) : (ниже по строкам)
sw t4, 0(a7)		# t4 = a7 (присваиваем номер строки с макс. суммой)
add a6, x0, t5		# a6 = t5 (обновляем значение макс. суммы)

default:
addi t4, t4, 1		# j++
blt t4, t2, init    # (j < M) ? (->init) : (ниже по строкам)
ret                 # переход к адресу возврата ra