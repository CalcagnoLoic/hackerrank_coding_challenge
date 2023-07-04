def pyramid(n):
    for i in range(n):
        print("."*(n-i-1) + "*"*(2*i+1))

if __name__ == '__main__':
    pyramid(5)
