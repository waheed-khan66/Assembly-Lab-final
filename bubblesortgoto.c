#include <stdio.h>

void bubbleSort(int arr[], int n) {
    int i = 0, j;
    loop_i:
    if (i >= n-1) return;
    j = 0;
    loop_j:
    if (j >= n-i-1) {
        i++;
        goto loop_i;
    }
    if (arr[j] > arr[j+1]) {
        int temp = arr[j];
        arr[j] = arr[j+1];
        arr[j+1] = temp;
    }
    j++;
    goto loop_j;
}

void printArray(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

int main() {
    int arr[] = {5,22,32,89,95};
    int n = sizeof(arr) / sizeof(arr[0]);
    bubbleSort(arr, n);
    printf("Sorted array: \n");
    printArray(arr, n);
    return 0;
}
