import xml.etree.ElementTree as ET

mytree = ET.parse('xmldocument.xml.txt')
myroot = mytree.getroot()

# iterating through the price values.
for prices in myroot.iter('price'):
	# updates the price value
	prices.text = str(float(prices.text)+10)
	# creates a new attribute
	prices.set('newprices', 'yes')

# creating a new tag under the parent.
# myroot[0] here is the first food tag.
ET.SubElement(myroot[0], 'tasty')
for temp in myroot.iter('tasty'):
	# giving the value as Yes.
	temp.text = str('YES')

# deleting attributes in the xml.
# by using pop as attrib returns dictionary.
# removes the itemid attribute in the name tag of
# the second food tag.
myroot[1][0].attrib.pop('itemid')

# Removing the tag completely we use remove function.
# completely removes the third food tag.
myroot.remove(myroot[2])

mytree.write('output.xml')
