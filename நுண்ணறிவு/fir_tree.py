import  sys

def gen_leaves(height, ):
    tree = []
    w = 1
    for i in range(height):
        evn = i+1 if i%2 else i+2
        tree.append(w)        
        for k in range(3+i):
            w += 2
            tree.append(w)
        w -= evn
    return tree

def gen_trunk(tree_height):
    trunk = tree_height if tree_height%2 else tree_height+1
    tree = [trunk] * tree_height
    return tree
    

def print_tree(tree, symbol = "*", tree_width=0):
    out = ''
    nl = 0
    if tree_width == 0:
        tree_width = max(tree)
    for size in tree:
        s_count = (tree_width - size)//2
        out += '\n'* nl +' '* s_count + symbol*size
        nl = 1
    print(out, end="\n")
 
 
if __name__ == '__main__':
    tree_height = int(sys.argv[1])
    if tree_height>0:
        tree = gen_leaves(tree_height)
        print_tree(tree,'*')
        tree_width = max(tree)
        tree = gen_trunk(tree_height)
        print_tree(tree,'|', tree_width)

