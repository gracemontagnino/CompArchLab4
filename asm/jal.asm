addi $v0,$zero,7
main:
	jal rawr
	addi $v1,$zero,6
	j exit
rawr:
	add $v0,$v0,7
	jr $ra
exit:
