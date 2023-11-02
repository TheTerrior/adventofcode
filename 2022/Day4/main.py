from functools import reduce
with open("input.txt") as file:
    nums = list(map(lambda x: int(x), file.read().replace("\n", " ").replace(",", " ").replace("-", " ").split(" ")))
print((reduce(lambda a, x: a+1 if (x[0] <= x[2] and x[1] >= x[3]) or (x[2] <= x[0] and x[3] >= x[1]) else a, chunked, 0), reduce(lambda a, x: a+1 if (x[0] >= x[2] and x[0] <= x[3]) or (x[2] >= x[0] and x[2] <= x[1]) else a, chunked, 0)) if (chunked := [(nums[i*4], nums[i*4+1], nums[i*4+2], nums[i*4+3]) for i in range(len(nums) // 4)]) else 0)

