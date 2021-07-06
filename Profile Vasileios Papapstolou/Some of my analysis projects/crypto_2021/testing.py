test_str = "M"
print("The original string is : " + str(test_str))
res = ''.join(format(i) for i in bytearray(test_str, encoding ='utf-8'))
print("The string after binary conversion : " + str(res))
