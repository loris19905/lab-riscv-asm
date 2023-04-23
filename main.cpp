#include <cstdio>
#include <stdlib.h>

int find_row(int* arr, int N, int M)
{
    int nec_row = 0;
    int biggest_sum = 0;

    for (int i = 0; i < N; i++)
    {
        int sum = 0;
        for (int j = 0; j < M; j++)
        {
            sum += arr[i*M+j];
        }
        printf("Row %d sum = %d\n", i, sum);
        if (sum > biggest_sum)
        {
            nec_row = i;
        }
    }

    return nec_row;
}

int main()
{
    int arr[6][6] = { 0 };
    for (int i = 0; i < 6; i++)
    {
        for (int j = 0; j < 6; j++)
        {
            arr[i][j] = rand() % 10;
            printf("% d\t", arr[i][j]);
        }
        printf("\n");
    }

    int nec_row = find_row(&arr[0][0], 6, 6);
    printf("Row with bigges sum = %d\n", nec_row);

    return 0;
}