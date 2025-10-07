# Name        : Ethan Miles
# Username    : enmiles
# Description : This program takes in a bill amount, a tip amount, and the amount of people eating to determine how much
# The bill costs with the tip, how much the bill costs rounded up, and how much everyone owes

.text
    # Initialize registers we plan to use
    li			$t0, 0				# $t0 holds the value of the meal pre tip
	li  		$t1, 0				# $t1 holds the tip percentage
	li			$t2, 0				# $t2 holds the tip amount
	li 			$t3, 0				# $t3 holds the total amount of the bill
	li			$t4, 100			# $t4 will divide $t2 to find the amount for the tip
	li 			$t5, 0				# $t5 is the temp variable to check the actual amounts divisibility
	li			$t6, 0				# $t6 will hold the amount of people dining
	li			$t7, 0				# $t7 will be the amount each person owes
	li			$t8, 0				# $t8 stores the bill with the tip
	
    li          $v0, 5              # syscall 5 = read integer into $v0
    syscall
    blez        $v0, terminate      # Stop if we read a 0
    add         $t0, $v0, $t0       # Adds the balance to a register
    
    li          $v0, 5              # syscall 5 = read integer into $v0
    syscall
    bltz		$v0, terminate		 # If the tip is <= 0, terminate
    add			$t1, $v0, $t1		 # Track the tip amount
    
    li          $v0, 5              # syscall 5 = read integer into $v0
    syscall
    bltz		$v0, terminate		# If the people is <= 0, terminate
    add			$t6, $v0, $t6		# Track the people
	
	move 		$t2, $t1			# Does all the fancy math to store the tip amount
	mult		$t2, $t0
	mflo		$t2
	div			$t2, $t4
	mflo		$t2
	
	add			$t3, $t0, $t2		# Adds the total amount to two registers, one to keep and one to make the actual amount
	move		$t8, $t3
loop1:
	move		$t5, $t3			# Loops until balance is divisible by 100
	div			$t5, $t4
	mfhi		$t5
	beqz		$t5, loop2
	addi		$t3, $t3, 1
	b			loop1
	
	
	
loop2:
	move		$t5, $t3			# Loops until balance is divisble by the people
	div			$t5, $t6
	mfhi		$t5
	beqz		$t5, done
	addi		$t3, $t3, 100
	b			loop2
	
done:
    move		$t7, $t3			# Math to find how much everyone owes
    div			$t7, $t6
    mflo		$t7
    
    # Print a linefeed to separate the input and output
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	# Print the tip amount
    move        $a0, $t2            # Copy $t1 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	# Print the total amount
    move        $a0, $t8            # Copy $t1 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	# Print the actual amount
    move        $a0, $t3            # Copy $t1 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall
    
    # Print the amount owed each
    move        $a0, $t7            # Copy $t1 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	terminate:						# Ends the program
	li		$v0, 10
	syscall
