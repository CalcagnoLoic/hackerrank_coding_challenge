def count_substring(string, sub_string):
    count = 0 
    x = string.find(sub_string)
    
    while x != -1:
        count += 1
        x = string.find(sub_string, x+1)
    return count
        

if __name__ == '__main__':
    string = input().strip()
    sub_string = input().strip()
    
    count = count_substring(string, sub_string)
    print(count)