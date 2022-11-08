:: This batch cmd is run as the final step in the installation of PAGE.
:: It creates the files page.bat and winpage.bat.

@>"..\winpage.bat" echo @start /min python3 "%%~dp0page.py" %%1 %%2 %%3
@>"..\page.bat" echo @start /min python3 "%%~dp0page.py" %%1 %%2 %%3
