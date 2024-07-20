.data
array: .long 22, 5, 89, 95, 32  # Array of 5 elements
output_sorted_asc: .asciz "Sorted array (ascending): %ld %ld %ld %ld %ld\n"  # Output format string for ascending sorted array
output_sorted_desc: .asciz "Sorted array (descending): %ld %ld %ld %ld %ld\n"  # Output format string for descending sorted array

.text
.global _main
.extern _printf

print_array:
    pushl %ebp
    movl %esp, %ebp

    movl 8(%ebp), %ebx  # Load the address of the array into %ebx
    movl 12(%ebp), %ecx  # Load the format string into %ecx

    pushl 16(%ebx)  # Push each array element onto the stack
    pushl 12(%ebx)
    pushl 8(%ebx)
    pushl 4(%ebx)
    pushl (%ebx)
    pushl %ecx  # Push the format string onto the stack
    call _printf  # Call printf to print the array
    addl $24, %esp  # Clean up the stack (5 elements + format string = 6*4 bytes)

    movl %ebp, %esp
    popl %ebp
    ret

bubble_sort_asc:
    pushl %ebp
    movl %esp, %ebp
    subl $16, %esp

    movl $5, -4(%ebp)  # Set loop bound (number of elements) to 5

outer_loop_asc:
    decl -4(%ebp)  # Decrement outer loop counter
    cmpl $0, -4(%ebp)  # Compare counter with 0
    jle end_sort_asc  # If counter <= 0, sorting is done

    movl $0, -8(%ebp)  # Initialize inner loop counter to 0

inner_loop_asc:
    movl -8(%ebp), %edx  # Load inner loop counter into %edx
    movl 8(%ebp), %ebx  # Load the address of the array into %ebx

    movl (%ebx, %edx, 4), %eax  # Load array[j] into %eax
    movl 4(%ebx, %edx, 4), %ecx  # Load array[j+1] into %ecx

    cmpl %ecx, %eax  # Compare array[j] with array[j+1]
    jle no_swap_asc  # If array[j] <= array[j+1], no need to swap

    # Swap array[j] and array[j+1]
    movl %ecx, (%ebx, %edx, 4)  # Store array[j+1] into array[j]
    movl %eax, 4(%ebx, %edx, 4)  # Store array[j] into array[j+1]

no_swap_asc:
    incl -8(%ebp)  # Increment inner loop counter
    cmpl $4, -8(%ebp)  # Compare inner loop counter with 4
    jl inner_loop_asc  # If counter < 4, continue inner loop

    jmp outer_loop_asc  # Repeat outer loop

end_sort_asc:
    movl %ebp, %esp
    popl %ebp
    ret

bubble_sort_desc:
    pushl %ebp
    movl %esp, %ebp
    subl $16, %esp

    movl $5, -4(%ebp)  # Set loop bound (number of elements) to 5

outer_loop_desc:
    decl -4(%ebp)  # Decrement outer loop counter
    cmpl $0, -4(%ebp)  # Compare counter with 0
    jle end_sort_desc  # If counter <= 0, sorting is done

    movl $0, -8(%ebp)  # Initialize inner loop counter to 0

inner_loop_desc:
    movl -8(%ebp), %edx  # Load inner loop counter into %edx
    movl 8(%ebp), %ebx  # Load the address of the array into %ebx

    movl (%ebx, %edx, 4), %eax  # Load array[j] into %eax
    movl 4(%ebx, %edx, 4), %ecx  # Load array[j+1] into %ecx

    cmpl %eax, %ecx  # Compare array[j] with array[j+1]
    jle no_swap_desc  # If array[j] >= array[j+1], no need to swap

    # Swap array[j] and array[j+1]
    movl %ecx, (%ebx, %edx, 4)  # Store array[j+1] into array[j]
    movl %eax, 4(%ebx, %edx, 4)  # Store array[j] into array[j+1]

no_swap_desc:
    incl -8(%ebp)  # Increment inner loop counter
    cmpl $4, -8(%ebp)  # Compare inner loop counter with 4
    jl inner_loop_desc  # If counter < 4, continue inner loop

    jmp outer_loop_desc  # Repeat outer loop

end_sort_desc:
    movl %ebp, %esp
    popl %ebp
    ret

_main:
    # Sort the array in ascending order
    pushl $array
    call bubble_sort_asc
    addl $4, %esp

    # Print sorted array (ascending)
    pushl $output_sorted_asc
    pushl $array
    call print_array
    addl $8, %esp

    # Restore the original array for descending sort
    movl $22, array
    movl $5, array + 4
    movl $89, array + 8
    movl $95, array + 12
    movl $32, array + 16

    # Sort the array in descending order
    pushl $array
    call bubble_sort_desc
    addl $4, %esp

    # Print sorted array (descending)
    pushl $output_sorted_desc
    pushl $array
    call print_array
    addl $8, %esp

    xorl %eax, %eax  # Zero out %eax (set return value to 0)
    ret  # Return from the function

