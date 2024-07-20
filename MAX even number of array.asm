.data
arr: .long 2, 4, 5, 6, 7            # Define an array of integers
outp: .asciz "The maximum even value is = %ld at index = %ld\n"  # Define the format string for printf

.text
.global _main
_main:
    movl $arr, %ebx                 # Load the address of arr into register %ebx
    movl $-1, %eax                  # Initialize index of max even number to -1 (indicating no even number found yet)
    movl $-2147483648, %ecx         # Initialize %ecx with the smallest possible integer

    movl $0, %edx                   # Initialize loop counter (%edx) to 0

start_loop:
    cmpl $5, %edx                   # Compare loop counter (%edx) with 5 (length of arr)
    jge end_loop                    # Jump to end_loop if %edx >= 5

    movl (%ebx,%edx,4), %esi        # Load arr[%edx] (current element) into %esi
    test $1, %esi                    # Test if the current element is even
    jnz skip_update                 # Jump to skip_update if current element is odd

    cmpl %ecx, %esi                 # Compare current element (%esi) with current max even number (%ecx)
    jle skip_update                 # Jump to skip_update if current element <= max even number

    movl %esi, %ecx                 # Update max even number (%ecx) to current element
    movl %edx, %eax                 # Update index of max even number (%eax) to current index (%edx)

skip_update:
    add $1, %edx                    # Increment loop counter (%edx)
    jmp start_loop                  # Jump to start_loop to continue looping

end_loop:
    pushl %eax                      # Push index of max even number (%eax) onto the stack (argument for printf)
    pushl %ecx                      # Push max even number (%ecx) onto the stack (argument for printf)
    push $outp                      # Push format string address onto the stack
    call _printf                    # Call printf function
    addl $12, %esp                  # Clean up stack after function call (remove arguments)

    xorl %eax, %eax                 # Set return value to 0 (indicating successful execution)
    ret                             # Return from main
