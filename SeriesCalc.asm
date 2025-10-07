# Name        : Ethan Miles
# Username    : enmiles
# Description : This program takes in integers from the user until the input 0, then the program will calculate and print
# how many integers were inputed, the sum, the max, and the min of those integers

.text
    # Initialize registers we plan to use
    li			$t0, 0				# $t0 will store count of numbers in series
	li  		$t1, 0				# $t1 is the sum
	li 			$t2, 0				# $t2 is the max
	li 			$t3, 0				# $t3 is the min
	li			$t4, 0				# $t4 will temporarily store the potential max and min number
loop:
    li          $v0, 5              # syscall 5 = read integer into $v0
    syscall

    beqz        $v0, done           # Stop if we read a 0
    addi        $t0, $t0, 1         # Increment our count of numbers in the series
    add			$t1, $v0, $t1		 # Adds to the sum
    
    add 		$t4, $v0, $t1		# Adds onto the temporary register holding the min or max
	bgt			$t2, $t4, min		# Checks if the current max is greater than the temp max, if so , it doesn't add the next value
	move		$t2, $t1			# Creates new max

min:
	add 		$t4, $v0, $t1		# Adds current number to temp min
	blt			$t3, $t4, loop		# Checks if min is lower than the temp min, if so, don't add the next value
	move		$t3, $t1			# Creates new min

    b           loop                # Go back to start and read another integer

done:
    # Print a linefeed to separate the input and output
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

    # Print the count
    move        $a0, $t0            # Copy $t0 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	# Print the sum
    move        $a0, $t1            # Copy $t1 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	# Print the max
    move        $a0, $t2            # Copy $t2 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

	# Print the min
    move        $a0, $t3            # Copy $t3 into $a0 in order to print it
    li          $v0, 1              # syscall 1 = print integer in $a0
    syscall
    li          $v0, 11             # syscall 11 = print character in $a0
    addi        $a0, $0, 10         # ASCII code 10 is a linefeed
    syscall

    li          $v0, 10             # syscall 10 = terminate execution
    syscall
