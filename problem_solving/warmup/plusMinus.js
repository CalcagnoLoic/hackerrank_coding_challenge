/*
 * Complete the 'plusMinus' function below.
 * Given an array of integers, calculate the ratios
 * of its elements that are positive, negative, and zero.
 * The function should not return a value.
 *
 * The function accepts INTEGER_ARRAY arr as parameter.
 */

function plusMinus(arr) {
    let arrLength = arr.length;
    let positiveNumber = arr.filter((e) => e > 0).length / arrLength;
    let negativeNumber = arr.filter((e) => e < 0).length / arrLength;
    let nullNumber = arr.filter((e) => e == 0).length / arrLength;

    console.log(
        positiveNumber.toFixed(6) +
            "\n" +
            negativeNumber.toFixed(6) +
            "\n" +
            nullNumber.toFixed(6)
    );
}
