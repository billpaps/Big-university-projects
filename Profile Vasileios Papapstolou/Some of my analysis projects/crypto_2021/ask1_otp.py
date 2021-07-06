import secrets

def encrypt(message, key):
    # message = word_to_bit(message)


    encrypted_msg = []
    for i in range(len(message)):
        encrypted_msg.append(key[i] ^ message[i])
    return encrypted_msg

def decrypt(message, key):
    # message = word_to_bit(message)

    decrypted_msg = []
    for i in range(len(message)):
        decrypted_msg.append(message[i] ^ key[i])
    return decrypted_msg


# Convert words to bit. A -> 0, B -> 1
def word_to_bit(plaintext):
    pinakas1c = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                 'U', 'V', 'W', 'X', 'Y', 'Z', '.', '!', '?', '(', ')', '-']
    pinakas1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
                28, 29, 30, 31]

    new_plaintext_list = []
    for i in plaintext:
        for j in range(32):
            if i == pinakas1c[j]:
                new_plaintext_list.append(pinakas1[j])
    return new_plaintext_list

# Convert words to bit. A -> 0, B -> 1
def bit_to_word(plaintext):
    pinakas1c = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
                 'U', 'V', 'W', 'X', 'Y', 'Z', '.', '!', '?', '(', ')', '-']
    pinakas1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27,
                28, 29, 30, 31]

    new_plaintext_list = []
    for i in plaintext:
        for j in range(32):
            if i == pinakas1[j]:
                new_plaintext_list.append(pinakas1c[j])
    return new_plaintext_list



message = 'MISTAKESAREASSERIOUSASTHERESULTSTHEYCAUSE'
message = word_to_bit(message)

# Generate random key
key = []
for i in message:
    key.append(secrets.randbelow(32))


encrypted = encrypt(message, key)
decrypted = decrypt(encrypted, key)

encrypted = bit_to_word(encrypted)
decrypted = bit_to_word(decrypted)

print("Encrypted message is: ")
for i in encrypted:
    print(i, end='')

print("\n\nDecrypted message is: ")
for i in decrypted:
    print(i, end='')
