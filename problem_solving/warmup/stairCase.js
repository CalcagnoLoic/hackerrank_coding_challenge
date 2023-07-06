/*
 * Complete the 'staircase' function below.
 *    #
     ##
    ###
   ####
 *
 * The function accepts INTEGER n as parameter.
 */

function staircase(n) {
    for (let i = 1; i <= n; i++) {
        console.log(" ".repeat(n - i) + "#".repeat(i));
    }
}
