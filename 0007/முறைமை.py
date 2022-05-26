import platform

print(platform.platform())
print(platform.system())
print(platform.machine())
print(platform.version())

print("")
print(dir(platform))
help("keywords")

ec= { 'a':1, 'b':2, 'c':3}

del ec['c']

print (ec)
