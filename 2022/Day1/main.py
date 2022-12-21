import itertools
from functools import reduce

def main():
    with open("input.txt", "r") as file:
        all_lines = file.readlines()
    concat_lines = reduce(lambda x, y: x + y, all_lines)
    elves_raw = concat_lines.split("\n\n")
    elves = []
    for raw in elves_raw: #iterate through all elf numbers
        elves.append(0)
        splitted = raw.split("\n") #split all of the elf's numbers
        for num in splitted: #for each of the elf's numbers, push it to their index
            elves[-1] += int(num)
        
    #print(elves.index(max(elves)))
    #print(max(elves))
    elves.sort()
    print(elves[-1] + elves[-2] + elves[-3])

if __name__ == "__main__":
    main()


