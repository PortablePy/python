# Calendar Module
from datetime import datetime, timedelta
import calendar

now = datetime.now()

testDate = now + timedelta(days=2)
myFirstLinkedInCourse = now - timedelta(weeks=3)

print(testDate.date())
print(myFirstLinkedInCourse.date())

if testDate > myFirstLinkedInCourse:
    print("Comparison works")

cal = calendar.month(2001, 10)
print(cal)

cal2 = calendar.weekday(2001, 10, 11)
print(cal2)

print(calendar.isleap(1999))
print(calendar.isleap(2000))