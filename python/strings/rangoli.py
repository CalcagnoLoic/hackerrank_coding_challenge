def print_rangoli(size):
    letters = 'abcdefghijklmnopqrstuvwxyz'[0:size]
    
    for i in range(size-1, -size, -1):
        x = abs(i)
        line = letters[size:x:-1]+letters[x:size]
        print ("--"*x+ '-'.join(line)+"--"*x)

if __name__ == '__main__':
    n = int(input())
    print_rangoli(n)