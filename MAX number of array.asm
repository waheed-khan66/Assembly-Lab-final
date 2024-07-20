.data
array: .long 12, 14, 13, 21, 44  # Define an array of integers
output: .asciz "the maximum value is = %ld\n"  # Define the format string for printf

.text
.global _main
.extern _printf

_main:
    movl $array, %ebx       # Load the address of array into register %ebx
    movl (%ebx), %ecx       # Initialize %ecx with the first element of array (array[0])

    movl $1, %edx           # Initialize loop counter (%edx) to 1
    movl $0, %eax           # Initialize index counter (%eax) to 0

start_loop:
    cmpl $5, %edx           # Compare loop counter (%edx) with 5 (length of array)
    jge end_loop            # Jump to end_loop if %edx >= 5

    movl (%ebx, %edx, 4), %esi    # Load array[%edx] (current element) into %esi
    cmpl %esi, %ecx         # Compare current element with current max (%ecx)
    jge continue_loop       # Jump to continue_loop if current element <= max

    movl %esi, %ecx         # Update max (%ecx) to current element

continue_loop:
    add $1, %edx            # Increment loop counter (%edx)
    jmp start_loop          # Jump to start_loop to continue looping

end_loop:
    pushl %ecx              # Push max (%ecx) onto the stack (argument for printf)
    push $output            # Push format string address onto the stack
    call _printf            # Call printf function
    addl $8, %esp           # Clean up stack after function call (remove arguments)

    xorl %eax, %eax         # Set return value to 0 (indicating successful execution)
    ret                     # Return from main
