/*
 * Complete the 'diagonalDifference' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts 2D_INTEGER_ARRAY arr as parameter.
 */

function diagonalDifference(arr) {
    let sumDiagLeft = 0;
    let sumDiagRight = 0;

    for (let i = 0; i < arr.length; i++) {
        sumDiagLeft += arr[i][i];
        sumDiagRight += arr[i][arr.length - i - 1];
    }

    return Math.abs(sumDiagLeft - sumDiagRight);
}
