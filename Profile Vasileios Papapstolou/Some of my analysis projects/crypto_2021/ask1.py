def ksa(key):
    S = []
    for i in range(256):
        S.append(i)

    j = 0
    for i in range(256):
        j = (j + S[i] + key[i % len(key)]) % 256
        S[i], S[j] = S[j], S[i]

    return S


def encrypt(key, plaintext):
    key_list = []
    for i in key:
        key_list.append(ord(i))

    plaintext_list = []
    for i in plaintext:
        plaintext_list.append(ord(i))

    S = ksa(key_list)

    i = 0
    j = 0
    ciphertext_list = []
    for x in range(len(plaintext_list)):
        i = (i + 1) % 256
        j = (j + S[i]) % 256
        S[i], S[j] = S[j], S[i]
        K = S[(S[i] + S[j]) % 256]
        ciphertext_list.append(K ^ plaintext_list[x])
    print(ciphertext_list)
    ciphertext = ""
    for i in ciphertext_list:
        ciphertext += chr(i)

    return ciphertext


def decrypt(key, ciphertext):
    key_list = []
    for i in key:
        key_list.append(ord(i))

    ciphertext_list = []
    for i in ciphertext:
        ciphertext_list.append(ord(i))

    S = ksa(key_list)

    i = 0
    j = 0
    plaintext_list = []
    for x in range(len(ciphertext_list)):
        i = (i + 1) % 256
        j = (j + S[i]) % 256
        S[i], S[j] = S[j], S[i]
        K = S[(S[i] + S[j]) % 256]
        plaintext_list.append(K ^ ciphertext_list[x])

    plaintext = ""
    for i in plaintext_list:
        plaintext += chr(i)

    return plaintext


key = 'HOUSE'
plaintext = "MISTAKESAREASSERIOUSASTHERESULTSTHECAUSE"

ciphertext = encrypt(key, plaintext)
print(ciphertext)

plaintext = decrypt(key, ciphertext)
print(plaintext)
