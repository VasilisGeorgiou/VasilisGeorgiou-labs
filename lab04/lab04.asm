# Calculate the product of data elements of a list
# for MYΥ-402 - Computer Architecture
# Department of Computer Engineering, University of Ioannina
# Aris Efthymiou

        .globl main # declare the label main as global. 
        
        .text 
mult1:
        lw    $t0,0($a0)      #-----------------------------------------------------------------
        add   $t1,$zero,$zero # i use mult1 like an app in order to
        add   $s4,$zero,$zero # do calcultions and not like a subroutine
mult2:                         # because i didn't find it useful
		beq  $t1,$t0,exitmult # ---------------------------------------------------------------------
		add  $s4,$s4,$v0
		addi $t1,$t1,1
		j     mult2 	
exitmult:
		add   $v0,$zero,$s4
		addi  $sp,$sp,4
        j     exitlistProd







listProd:
        addi  $sp,$sp,-8
        sw    $ra,4($sp)
        bne   $a0,$zero,again #if a0 !=0 goto again
		addi  $v0,$zero,1	  # if a0 == 0 v0=1
		j     exitlistProd
again:
		sw    $a0,0($sp) # i save the address of the 1st item then of the 2nd etc.
		addi  $a0,$a0,4  
		lw    $a0,0($a0) # goes to the next item
		jal   listProd	 # again in listProd
		lw    $a0,4($sp) # when it finishes with the listProd v0=1 and here i get the address from the last item and then from last-1 etc.
		j     mult1		# goes to mult1 above
exitlistProd:
        lw    $ra,4($sp)
        addi  $sp,$sp,4
        jr    $ra
        
        
       # what i did is this (((((1*5)*4)*3)*2)*1)
       # because the code in java you give us in the pdf lab04 does that
       # may you wanted it different but i thought that this is the right way 


        ########################################################################
        #  Write your code above. Leave main as is.
        ########################################################################
main:
        # These are for providing input and testing, don't change this in your
        #  final submission
        # ----- Try it with the full list
        la    $a0, n1_d
        jal   listProd
        addu  $s0, $v0, $zero   # Move the result to s0 for tester to check
        # ----- Try it with a null pointer
        addu  $a0, $zero, $zero
        jal   listProd
        addu  $s1, $v0, $zero   # Move the result to s1 for tester to check
        # ----- Try it with 1 item list
        la    $a0, n5_d
        jal   listProd
        addu  $s2, $v0, $zero   # Move the result to s2 for tester to check
        # ----- Try mult by 0
        la    $a0, na_d
        jal   listProd
        addu  $s3, $v0, $zero   # Move the result to s3 for tester to check
		addi  $sp,$sp,16
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall                      # we are outta here.

        ###############################################################################
        # Data input.  Don't modify.
        ###############################################################################
       .data
# 1st item - head of the list!
n1_d: .word 1
n1_n: .word n2_d  # point to (beginning of) n2

# 3rd item
n3_d: .word 3
n3_n: .word n4_d

# 2nd item
n2_d: .word 2
n2_n: .word n3_d

# 5th item
n5_d: .word 5
n5_n: .word 0 # This is the last iterm in the list

# 4th item
n4_d: .word 4
n4_n: .word n5_d

# Alternative head of list. Value 0 to test mult by 0
na_d: .word 0
na_n: .word n2_d  # point to (beginning of) n2
