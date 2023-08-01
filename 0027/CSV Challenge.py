import csv
import datetime

def generate_csv(ஒரு_பட்டியல்):
    with open("results.csv","w+") as கோப்பு:
        
        தலைப்புகள்=[]
        for சி in ஒரு_பட்டியல்[0]:
            தலைப்புகள்.append(சி[0])
        எழுது = csv.writer(கோப்பு)
        
        எழுது.writerow(தலைப்புகள்)
        for வரி in ஒரு_பட்டியல்:
            வரிகள் =[]
            for சி in வரி:
                if isinstance(சி[1], datetime.date):
                    தரவு = சி[1].strftime("%m/%d/%Y") 
                elif isinstance(சி[1], tuple) or isinstance(சி[1],list):
                    தரவு = ",".join(சி[1])
                else:
                    தரவு = சி[1]
                வரிகள்.append(தரவு)
            எழுது.writerow(வரிகள்)
            
            
def parse_csv():
    with open("students.csv","r") as f:
        படி =csv.DictReader(f)
        வரிகள் = []
        for வரி in படி:
            [மா,நா,ஆ] = [int(த) for த in வரி['Birthdate'].split("/")]
            வரி['Birthdate'] = datetime.date(ஆ,மா,நா)
            வரி['Marks'] = [int(த) for த in வரி['Marks'].split(",")]
            வரிகள்.append(வரி)
    return வரிகள்
            
print(parse_csv())
        