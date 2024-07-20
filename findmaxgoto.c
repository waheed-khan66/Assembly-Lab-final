#include <stdio.h>

int findMax(int arr[], int n) {
    int max = arr[0];
    int i = 1;

    check:
    if (i >= n) goto done;

    if (arr[i] > max) {
        max = arr[i];
    }
    i++;
    goto check;

    done:
    return max;
}

int main() {
    int arr[] = {10, 324, 45, 90, 9808};
    int n = sizeof(arr) / sizeof(arr[0]);
    printf("Maximum number in the array is %d\n", findMax(arr, n));
    return 0;
}
