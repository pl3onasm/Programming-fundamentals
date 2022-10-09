import random

lst = [ i for i in range(0, 82) ]
random.shuffle(lst)
print(" ".join([ str(i) for i in lst ]))