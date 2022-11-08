
import sys

def is_id(str):
    print(str.isidentifier())

if __name__ == '__main__':
    test_string = sys.argv[1]
    if test_string == "" \
                  or test_string[-1] == "\\" \
                  or test_string[-1] == "'":
        print(False)
    else:
        eval("is_id" +  "('" + sys.argv[1] + "')")
