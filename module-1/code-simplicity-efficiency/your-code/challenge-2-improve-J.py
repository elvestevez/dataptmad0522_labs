import random
import sys
import time


def RandomStringGenerator(l=12, a=['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','0','1','2','3','4','5','6','7','8','9']):
    s = ""
    return ''.join(random.sample(a,l))

def BatchStringGenerator(n, a=8, b=12):
    if a < b:
        r = [RandomStringGenerator(random.choice(range(a, b))) for i in range(n)]
    elif a == b:
        r = [RandomStringGenerator(random.choice(range(a, b+1))) for i in range(n)]
    else:
        sys.exit('Incorrect min and max string lengths. Try again.')
    return r


a = input('Enter minimum string length: ')
b = input('Enter maximum string length: ')
n = input('How many random strings to generate? ')

start = time.time()

print(BatchStringGenerator(int(n), int(a), int(b)))

end = time.time()

print(f'time in functions: {end - start}')
