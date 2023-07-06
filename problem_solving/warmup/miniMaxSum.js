/*
 * Complete the 'miniMaxSum' function below.
 *
 * The function accepts INTEGER_ARRAY arr as parameter.
 */

const miniMaxSum = (arr) => {
    let [min, max] = [Math.min(...arr), Math.max(...arr)];
    let sum = arr.reduce((a, b) => a + b, 0);

    console.log(sum - max, sum - min);
};
