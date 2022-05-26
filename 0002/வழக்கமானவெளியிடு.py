import re

string = "34 heL,Some123Heldummy;text.234tys"
pat0 = r"\d+"
pat1 = r"hel"
pat2 = r"[,;.]"
replacm = "Anish"
inputvar = string
rep = replacm
cpd_patt = re.compile(pat0)
c_pat = re.compile(pat1, re.IGNORECASE)
c_pat1 = re.compile(pat1, re.IGNORECASE)
if c_pat.search(string):
    print("Found")
# if c_pat1.match(string):
#     print ("F1ound")
print(re.split(pat2, string))

cpd_patt_sr_md = cpd_patt.search(string)
search_fn = re.search(pat0, string)  # First found Match object
match_fn = re.match(pat0, string)  # only at begining
subn_fn = re.subn(pat0, replacm, string)  # replace all with count
sub_fn = re.sub(pat0, replacm, string)  # replace all without count
findall_fn = re.findall(pat0, string)
occ = re.finditer(pat0, string)
occ_result = [o.group() for o in occ]

# print(dir(re))
# print(re.__dict__.keys())
print(repr(re))
print(help(re))
