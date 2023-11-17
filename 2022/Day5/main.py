with open("input.txt") as file:
    inp = file.read().split("\n\n")
start = inp[0].splitlines()
print(start)
instructions = inp[1].splitlines()
temp = len(list(filter(None, start[-1].split(" ")))) #remove falsy lists
cols = [""] * temp
for j in range(len(start)-1):
    for i in range(temp):
        print(start[j][i*4+1])
print(cols)


