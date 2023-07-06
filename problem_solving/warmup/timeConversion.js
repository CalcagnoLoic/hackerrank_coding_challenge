/*
 * Complete the 'timeConversion' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts STRING s as parameter.
 */

function timeConversion(s) {
    let hours = s.slice(0, 2);
    const formatTime = s.slice(-2);
    let restTime = s.slice(2, -2);
    let convertTime;

    if (formatTime === "PM") {
        convertTime = Number(hours) === 12 ? hours : Number(hours) + 12;
    } else {
        convertTime = Number(hours) === 12 ? "00" : hours;
    }

    return convertTime + restTime;
}
