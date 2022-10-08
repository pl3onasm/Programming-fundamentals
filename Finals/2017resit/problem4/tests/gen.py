import random

lst = [i for i in range(0, 65)]
random.shuffle(lst)
for i in lst:
    print(i, end=" ")