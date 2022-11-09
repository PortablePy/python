import re
import pickle
import os
import csv
import requests
from bs4 import BeautifulSoup

PAGE="http://localhost:8000/auto_mpg.html"


def process_car_blocks(soup):
    """Extract information from repeated divisions"""
    car_blocks = soup.find_all('div', class_='car_block')
    rows = []
    for cb in car_blocks:
        row = extract_data(cb)
        rows.append(row)
    print(f"We have {len(rows)} rows of scraped car data")
    print(rows[0])
    print(rows[-1])

    with open("scraped_cars.csv", "w") as f:
        writer = csv.DictWriter(f, fieldnames=row.keys())
        writer.writeheader()
        writer.writerows(rows)


def extract_data(cb):
    str_name = cb.find('span', class_='car_name').text
    str_cylinders = cb.find('span', class_='cylinders').text
    cylinders = int(str_cylinders)
    assert cylinders > 0, f"Expecting cylinders to be positive not {cylinders}"
    str_weight = cb.find('span', class_='weight').text
    weight = int(str_weight.replace(',', ''))
    assert weight > 0, f"Expecting weight to be positive not {weight}"
    territory, year = extract_territory_year(cb)
    acceleration = float(cb.find('span', class_='acceleration').text)
    assert acceleration > 0, f"Expecting acceleration to be positive"
    mpg = extract_mpg(cb)
    hp = extract_horsepower(cb)
    displacement = extract_displacement(cb.text)
    row = dict(name=str_name,
               cylinders=cylinders,
               weight=weight,
               year=year,
               territory=territory,
               acceleration=acceleration,
               mpg=mpg,
               hp=hp,
               displacement=displacement)
    return row


def extract_territory_year(cb):
    str_from = cb.find('span', class_='from').text
    year, territory = str_from.strip('()').split(',')
    year = int(year.strip())
    assert year > 0, f"Expecting year to be positive not {year}"
    territory = territory.strip()
    assert len(territory) > 1, f"Expecting territory to be a \
        useful string not {territory}"
    return territory, year


def extract_horsepower(cb):
    hp_str = cb.find('span', class_='horsepower').text
    try:
        hp = float(hp_str)
        assert hp > 30, f"Expecting reasonable hp, not {hp}"
    except ValueError:
        hp = "NULL"
    return hp


def extract_mpg(cb):
    mpg_str = cb.find('span', class_='mpg').text
    try:
        mpg = float(mpg_str.split(' ')[0])
        assert mpg > 7, f"Expecting reasonable mpg, not {mpg}"
    except ValueError:
        mpg = "NULL"
    return mpg


def extract_displacement(text):
    displacement_str = re.findall(r'.* (\d+.\d+) cubic inches', text)[0]
    displacement = float(displacement_str)
    assert displacement > 60, f"Expecting a reasonable \
displacement, not {displacement}"
    return displacement


if __name__ == "__main__":
    filename = 'scraped_page_result.pickle'
    if os.path.exists(filename):
        with open(filename, 'rb') as f:
            print(f"Loading cached {filename}")
            result = pickle.load(f)
    else:
        print(f"Fetching {PAGE} from the internet")
        result = requests.get(PAGE)
        with open(filename, 'wb') as f:
            print(f"Writing cached {filename}")
            pickle.dump(result, f)
    assert result.status_code == 200, f"Got status code {result.status_code} \
which isn't a success"
    source = result.text
    soup = BeautifulSoup(source, 'html.parser')
    process_car_blocks(soup)
