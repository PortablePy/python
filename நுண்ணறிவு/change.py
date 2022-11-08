from datetime import datetime

def friday_the_13th():
    cur_date = datetime.today()
    y1 = cur_date.year
    m1 = cur_date.month
    d1 = cur_date.day
    if d1 >13:
        if m1 == 12:
            m1 = 1
            y1 += 1
        else:
            m1 += 1
    d1 = 13
    cur_date = datetime(y1, m1, d1)
    while not cur_date.weekday() == 4:
        if m1 == 12:
            m1 = 1
            y1 += 1
        else:
            m1 += 1
        cur_date = datetime(y1, m1, d1)
    return cur_date.strftime("%Y-%m-%d")

print(friday_the_13th())