import pandas as pd
import math
from functools import reduce
import operator

with open('vigenere.txt', 'r', encoding='utf-8-sig') as file:
    coded_msg = file.read().replace('\n', '')
print(coded_msg)

# Alphabet dictionary
alphabet = {
    "A": 0,"B": 1,"C": 2,"D": 3,"E": 4,"F": 5,"G": 6,"H": 7,"I": 8,"J": 9,"K": 10,"L": 11,"M": 12,"N": 13,
    "O": 14,"P": 15,"Q": 16,"R": 17,"S": 18,"T": 19,"U": 20,"V": 21,"W": 22,"X": 23,"Y": 24,"Z": 25
}
reverse_alphabet = {v: k for k, v in alphabet.items()}

# Kasiski attack for letter frequency

def kasiski_attack(text, n):
    i = 0
    count = {}

    for i in range(0, len(text) - (n - 1)):
        s = text[i]
        for j in range(i + 1, i + n):
            if j < len(text):
                s = s + text[j]
        if s in count:
            count[s] += 1
        else:
            count[s] = 1

    return count

# Find greatest common divisor
def find_gcd(list):
    x = reduce(math.gcd, list)
    return x

# Custom substraction for numbers 0-25 aka letters A-Z
def cyclic_subtraction(a,b):
    temp = a - b
    if temp < 0:
        temp = 26 + temp
    return temp


 # Anayzing the decrypted text
columns = ['Length', 'Substring', 'Frequency']
df = pd.DataFrame(columns=columns)

# All substrings with length>=4 and frequency>=3
for q in range(4, 10):
    count = kasiski_attack(coded_msg, q)
    for key in count:
        if count[key] > 2:
            df = df.append({'Length': q, 'Substring': key, 'Frequency': count[key]}, ignore_index=True)
            # print ("Length:", q, " substring:", key, " freq:", count[key])

# Find the distances and gcd and adding them to the dataframe
la = [[] for _ in range(52)]
for index, row in df.iterrows():
    count_stars = 0
    count = 0
    start = False
    for char in coded_msg.replace(row['Substring'], "*"):
        if char == "*":
            if count != 0:
                la[index].append(count - 1)
            count_stars = count_stars + 1
            start = True
            count = 0
        if count_stars == row['Frequency']:
            break
        if start == True:
            count = count + 1

df['Distances'] = la

gcd_list = []
for index, row in df.iterrows():
    gcd_list.append(find_gcd(row['Distances']))

df['GCD'] = gcd_list


# Narrowing the above results according to gcd
indexNames = df[df['GCD'] < 3 ].index

df.drop(indexNames , inplace=True)
df.reset_index()


n=7
#https://stackoverflow.com/questions/22571259/split-a-string-into-n-equal-parts
parts = [coded_msg[i:i+n] for i in range(0, len(coded_msg), n)] # Split the message into n equal parts
#print(parts)
mapping = [list(word) for word in parts] # For each part we create a list with the letters of it
print(mapping)


# Creating n-buckets with letters from the columns of mapping
df_list = []
columns = ['Letter', 'Frequency']
df_letters = pd.DataFrame(columns = columns)
for j in range(0,n):
    letters = []
    for i in range(0,len(mapping)):
        letters.append(mapping[i][j])
    text = ''.join(map(str, letters))
    print(str(j))
    print(text)
    count = kasiski_attack(text, 1)
    #print(count)
    df_list.append(count)


# Code snippet just for testing reasons
# for i in range(0, n):
#     print(i)
#     print(df_list[i])

# Finding the letters with higher frequency
key_list = []
for i in range(0, n):
    temp = max(df_list[i].items(), key=operator.itemgetter(1))[0]
    print(temp + str(': ')+str(df_list[i][temp]))
    key_list.append(reverse_alphabet[cyclic_subtraction(alphabet[temp], 4)]) # We use 4 as E are the most frequent letter of english alphabet

# Taking the arithmetic form of the key's letters
print(key_list) # This is the key "EMPEROR"
for i in range(0,n):
    key_list[i] = alphabet[key_list[i]]
print(key_list)


# Message decryption
# Knowing the key we should only use it backwards to decipher the message
decrypted_message = []
i=0 # this variable helps us to iterate the key_list in a cyclic way
for letter in coded_msg:
    if i == len(key_list):
        i=0
    # Decrypting the letters one by one
    # We transform the letters of the encrypted message to numbers,
    # then we carry out the cyclic_subtraction and lastly we transform the result back to letters
    decrypted_message.append(reverse_alphabet[cyclic_subtraction(alphabet[letter], key_list[i])])
    i += 1
#print("".join(decrypted_message))

# The file will contain the decrypted message but without any punctuation marks or blank spaces
f = open("vigenere_decrypted.txt", "w")
f.write("".join(decrypted_message))
f.close()
# The corrected message is located in file "vigenere_decrypted_corrected.txt"