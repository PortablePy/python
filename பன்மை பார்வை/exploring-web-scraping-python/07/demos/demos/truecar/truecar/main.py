# https://stackoverflow.com/questions/21788939/how-to-use-pycharm-to-debug-scrapy-projects

from scrapy import cmdline


scrapy_command = 'scrapy crawl truecar -o truecar.csv'

cmdline.execute(scrapy_command.split())
