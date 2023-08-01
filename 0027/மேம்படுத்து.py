# importing the module.
import xml.etree.ElementTree as ET
XMLexample_stored_in_a_string ='''<?xml version ="1.0"?>
<COUNTRIES>
	<country name ="INDIA">
		<neighbor name ="Dubai" direction ="W"/>
	</country>
	<country name ="Singapore">
		<neighbor name ="Malaysia" direction ="N"/>
	</country>
</COUNTRIES>
'''
# parsing directly.
tree = ET.parse('xmldocument.xml')
root = tree.getroot()
# parsing using the string.
stringroot = ET.fromstring(XMLexample_stored_in_a_string)
# printing the root.
print(root)
print(stringroot)

# Element methods:
# 1)Element.iter(‘tag’) -Iterates over all the child elements(Sub-tree elements)
# 2)Element.findall(‘tag’) -Finds only elements with a tag which are direct children of the current element.
# 3)Element.find(‘tag’) -Finds the first Child with the particular tag.
# 4)Element.get(‘tag’) -Accesses the elements attributes.
# 5)Element.text -Gives the text of the element.
# 6)Element.attrib-returns all the attributes present.
# 7)Element.tag-returns the element name.


XMLexample_stored_in_a_string ='''<?xml version ="1.0"?>
<States>
	<state name ="TELANGANA">
		<rank>1</rank>
		<neighbor name ="ANDHRA" language ="Telugu"/>
		<neighbor name ="KARNATAKA" language ="Kannada"/>
	</state>
	<state name ="GUJARAT">
		<rank>2</rank>
		<neighbor name ="RAJASTHAN" direction ="N"/>
		<neighbor name ="MADHYA PRADESH" direction ="E"/>
	</state>
	<state name ="KERALA">
		<rank>3</rank>
		<neighbor name ="TAMILNADU" direction ="S" language ="Tamil"/>
	</state>
</States>
'''
# parsing from the string.
root = ET.fromstring(XMLexample_stored_in_a_string)
# printing attributes of the root tags 'neighbor'.
for neighbor in root.iter('neighbor'):
	print(neighbor.attrib)
# finding the state tag and their child attributes.
for state in root.findall('state'):
	rank = state.find('rank').text
	name = state.get('name')
	print(name, rank)

# MODIFYING:
# Modifying the XML document can also be done through Element methods.
# Methods:
# 1)Element.set(‘attrname’, ‘value’) – Modifying element attributes.
# 2)Element.SubElement(parent, new_childtag) -creates a new child tag under the parent.
# 3)Element.write(‘filename.xml’)-creates the tree of xml into another file.
# 4)Element.pop() -delete a particular attribute.
# 5)Element.remove() -to delete a complete tag.