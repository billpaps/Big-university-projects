from zipfile import ZipFile

zip_file = 'locked.zip'
eng_dict = 'english.txt'
check = 0

# Move the words from txt file to a list
with open(eng_dict) as ed:
    content = ed.readlines()
# you may also want to remove whitespace characters like `\n` at the end of each line
content = [x.strip() for x in content]
# print(len(content)) #394740 passwords

# Brute Force until we find the right password
i = 1
for password in content:
    print(i)
    i = i + 1
    try:
        with ZipFile(zip_file) as zf:
            zf.extractall(pwd=bytes(password,'utf-8'))
        check = 1
    except Exception:
        check = 0
        pass
    if check ==1:
        break;

# Password is in 268102 index

