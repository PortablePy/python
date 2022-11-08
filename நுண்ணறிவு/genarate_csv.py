import csv

def generate_csv(a_list):
    with csv.opencsv("results.csv","w+") as f:
        headers=[]
        for c in a_list[0]:
            header.append(c[0])
        writer = csv.Writer(f)
        
        writer.writerow(headers)
        for r in a_list:
            row =[]
            for c in r:
                row.append(c[1])
            writer.writerow(row)
            

meteo = [(('temperature', 42),('date', datetime.date(2017, 1, 22)),
   ('locations', ('Berlin', 'Paris')),
   ('weather', 'sunny')),
  (('temperature', -42),
   ('date', datetime.date(2017, 1, 22)),
   ('locations', ('Marseille', 'Moscow')),
   ('weather', 'cloudy'))]

generate_csv(meteo)


"""
temperature,date,locations,weather
42,01/22/2017,"Berlin,Paris",sunny
-42,01/22/2017,"Marseille,Moscow",cloudy
"""