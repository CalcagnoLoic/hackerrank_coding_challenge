liste = []
scores = []
    
if __name__ == '__main__':
    for _ in range(int(input())):
        name = input()
        score = float(input())
        liste+=[[name, score]]
        scores+=[score]
    i = sorted(list(set(scores)))[1]
        
    for x,y in sorted(liste):
        if y == i:
            print(x)