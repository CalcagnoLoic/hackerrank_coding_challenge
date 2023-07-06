/*
 * Complete the 'birthdayCakeCandles' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts INTEGER_ARRAY candles as parameter.
 */

const birthdayCakeCandles = (candles) => {
    const maxNumber = Math.max(...candles);
    return candles.filter((e) => e === maxNumber).length;
};
