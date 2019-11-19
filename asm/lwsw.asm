addi $sp, $zero, 0x3ffc
addi $a0  $zero, 7

addi $sp, $sp, -4
sw $a0, 0($sp)		# push($ra)

lw $v0, 0($sp)		# pop($ra)
addi $sp, $sp, 4