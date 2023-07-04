def palindrome(string):
    value_reverse = string[::-1]

    if string == value_reverse:
        print('test')
    else:
        print("test2")


def palindromeRecur(string):
    if len(string)<=1:
        return True
    else:
        return string[0] == string[-1] and \
        palindromeRecur(string[1:-1])

if palindromeRecur('kayak'):
    print("C'est un palindrome")
else:
    print("Ce n'est pas un palindrome")


if __name__ == '__main__':
    palindrome("kaezak")
