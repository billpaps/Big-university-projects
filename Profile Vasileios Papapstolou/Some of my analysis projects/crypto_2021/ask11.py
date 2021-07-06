def fast(a, g, N):
    g = bin(g)  # Turn to binary
    g = g[2:]  # Remove the 0b at the beginning

    d = 1
    x = a
    for i in range(len(g) - 1, -1, -1):
        if g[i] == str(1):
            d = (d * x) % N
        x = (x ** 2) % N
    return d


def compute_factors(n):  # Function to compute prime factors of a number
    factors = [];
    for i in range(1, n + 1):
        if n % i == 0:
            factors.append(i)

    return factors


def find_p_q(N):  # Function to find p and q

    factors = []

    factors = compute_factors(N)
    flag = False

    for i in range(1, len(factors)):  # Begin from 1 and not from 0 to avoid 1*N = N
        for j in range(i, len(factors)):
            if factors[j] * factors[i] == N:
                p = factors[j]
                q = factors[i]
                flag = True
        if flag == True:
            break
    return p, q


def φ(N):  # Function to compute (p-1)*(q-1)

    p, q = find_p_q(N)
    return (p - 1) * (q - 1)


def modInverse(a, m):  # Modular multiplicative inverse function from:
    a = a % m;  # https://www.geeksforgeeks.org/multiplicative-inverse-under-modulo-m/
    for x in range(1, m):
        if ((a * x) % m == 1):
            return x
    return 1


# (N,e) = (11413,19)
N = 11413
e = 19
# C is the encrypted message in ASCII
C = [3203,909,3143,5255,5343,3203,909,9958,5278,5343,9958,5278,4674,909,9958,792,909,4132,3143,9958,3203,5343,792,3143,4443]

f = φ(N)  # Compute φ(Ν) here

d = modInverse(e, f)  # I find d here with modular inversity

hiddenMessage = ''

for i in C:
    k = fast(i, d, N)
    hiddenMessage = hiddenMessage + chr(k)

print("Hidden Message:\n\n" + hiddenMessage)
