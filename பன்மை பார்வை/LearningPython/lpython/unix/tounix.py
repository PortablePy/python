import string, sys, os

# os.mkdir("converted")
for f in sys.argv[1:]:
    print f
    i = open(f, 'r')
    t = i.read()
    i.close()

    s = string.join(string.split(t, "\015\012"), "\012")
    o = open(f, 'w')
    o.write(s)
    o.close()

