dict_input = {"zero" : 0, "one" : 1, "two" : 2, "three" : 3, "four" : 4, "five" : 5}
dict_output = {0 : "zero", 1 : "one", 2 : "two", 3 : "three", 4 : "four", 5 : "five", 6 : "six", 7 : "seven",
               8: "eight", 9: "nine", 10: "ten"}
def calculator (a,b,c):
    x = dict_input.get(a)
    if x == None:
        return print("I am not able to answer this question. Check your input.")
    else:
        y = dict_input.get(c)
    if b == "plus":
        z = x+y
    else:
        z = x-y
    print("\n")
    print(f'{a} {b} {c} equals {dict_output.get(z)}')
    print("\n")
    return print("Thanks for using this calculator, goodbye :)")

print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')
a = input('Please choose your first number (zero to five): ')
b = input('What do you want to do? plus or minus: ')
c = input('Please choose your second number (zero to five): ')
calculator(a,b,c)

