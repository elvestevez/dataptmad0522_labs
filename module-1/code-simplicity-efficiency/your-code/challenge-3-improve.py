import time


def my_function(X):
    solutions = [[x,y,z] for x in range(5, X) for y in range(4, X) for z in range(3, X) if (x*x==y*y+z*z)]
    
    arr = [max(i) for i in solutions]
    if len(arr) == 0:
        return 0
    else:
        return max(arr)


X = input("What is the maximal length of the triangle side? Enter a number: ")

start = time.time()

print("The longest side possible is " + str(my_function(int(X))))

end = time.time()

print(f'time in functions: {end - start}')
