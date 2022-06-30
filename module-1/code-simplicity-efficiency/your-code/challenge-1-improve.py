# function transform str to int (from zero to five)
# next step: library word2number
def transform_to_int(text):
    if text == 'zero':
        return 0
    elif text == 'one':
        return 1
    elif text == 'two':
        return 2
    elif text == 'three':
        return 3
    elif text == 'four':
        return 4
    elif text == 'five':
        return 5

# function transform int to str (from -5 to 10)
# next step: library num2words
def transform_to_str(num):
    if num == -5:
        return 'negative five'
    elif num == -4:
        return 'negative four'
    elif num == -3:
        return 'negative three'
    elif num == -2:
        return 'negative two'
    elif num == -1:
        return 'negative one'
    elif num == 0:
        return 'zero'
    elif num == 1:
        return 'one'
    elif num == 2:
        return 'two'
    elif num == 3:
        return 'three'
    elif num == 4:
        return 'four'
    elif num == 5:
        return 'five'
    elif num == 6:
        return 'six'
    elif num == 7:
        return 'seven'
    elif num == 8:
        return 'eight'
    elif num == 9:
        return 'nine'
    elif num == 10:
        return 'ten'

# function return a message, operation and result
def message(num1, op, num2, result):
    text1 = transform_to_str(num1)
    text2 = transform_to_str(num2)
    text3 = transform_to_str(result)
    return f'{text1} {op} {text2} equals {text3}'

# function validate valid arguments to operate
def validate(num1, op, num2):
    if op == 'plus' or op == 'minus':
        if num1 != None and num1 >= 0 and num1 <= 5:
            if num2 != None and num2 >= 0 and num2 <= 5:
                return True
            else:
                return False
        else:
            return False
    else:
        return False

# function operate with arguments
def operator(num1, op, num2):
    if (op == 'plus'):
        return num1 + num2
    elif (op == 'minus'):
        return num1 - num2

# main
print('Welcome to this calculator!')
print('It can add and subtract whole numbers from zero to five')
a = input('Please choose your first number (zero to five): ')
b = input('What do you want to do? plus or minus: ')
c = input('Please choose your second number (zero to five): ')

a = transform_to_int(a)
c = transform_to_int(c)

if validate(a, b, c):
    result = operator(a, b, c)
    print(message(a, b, c, result))
else:
    print("I am not able to answer this question. Check your input.")

print("Thanks for using this calculator, goodbye :)")
