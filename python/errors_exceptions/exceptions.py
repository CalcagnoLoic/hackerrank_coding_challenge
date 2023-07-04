number = int(input())
for x in range(number):
    try:
        a,b = input().split()
        print(int(a)//int(b))
    except ZeroDivisionError as e:
        print("Error Code:", e)
    except ValueError as v:
        print("Error Code:", v)