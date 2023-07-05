/*
 * Complete the 'compareTriplets' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts following parameters:
 *  1. INTEGER_ARRAY a
 *  2. INTEGER_ARRAY b
 */

function compareTriplets(a, b) {
    let aliceScore = 0;
    let bobScore = 0;
    a.forEach((opt, i) => {
        a[i] > b[i] && aliceScore++;
        a[i] < b[i] && bobScore++;
    });

    return [aliceScore, bobScore];
}