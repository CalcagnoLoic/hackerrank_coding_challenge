N = int(input())

list=[];
for i in range(0,N):
    x=input().split();
    if x[0] == "insert":
        list.insert(int(x[1]),int(x[2]))
    elif x[0] == "append":
        list.append(int(x[1]))
    elif x[0] == "pop":
        list.pop();
    elif x[0] == "print":
        print(list)
    elif x[0] == "remove":
        list.remove(int(x[1]))
    elif x[0] == "sort":
        list.sort();
    else:
        list.reverse();