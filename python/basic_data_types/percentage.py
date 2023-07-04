n = int(input())
student_marks = {}
for _ in range(n):
    name, *line = input().split()
    scores = list(map(float, line))
    student_marks[name] = scores
query_name = input()

x = list(student_marks[query_name])
percentage = sum(x)/len(x)
print("{:.2f}".format(percentage))