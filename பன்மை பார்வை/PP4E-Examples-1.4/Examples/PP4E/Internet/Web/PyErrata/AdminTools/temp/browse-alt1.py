# on browse requests: fetch and display data in new page

import cgi, sys, string
sys.stderr = sys.stdout  # show errors

def generateRecord(record):
    print '<p><table border>'
    rowhtml = '<tr><th align=right>%s:<td>%s\n'
    for field in record.keys():
        if record[field] != '' and field != 'Description':
            print rowhtml % (field, cgi.escape(str(record[field])))

    field = 'Description'
    text  = string.strip(record[field])
    print rowhtml % (field, '<pre>' + cgi.escape(text) + '</pre>')
    print '</table></p><hr>'

def generatePage(dbase, kind='Errata'):
    form = cgi.FieldStorage()
    try:
        key = form['key'].value
    except KeyError:
        key = None

    print 'Content-type: text/html\n'
    print '<title>PP2E %s list</title>' % kind
    print '<h1>%s list, sorted by "%s"</h1><hr>' % (kind, str(key))

    if not form.has_key('indexed'):
        records = dbase().loadSortedTable(key)               # make list
        for record in records:
            generateRecord(record)

    else:
        keys, index = dbase().loadIndexedTable(key)
        print '<h2>Index</h2><ul>'
        section = 0                                          # make index
        for key in keys: 
            html = '<li><a href="#S%d">%s</a>' 
            print html % (section, cgi.escape(str(key)) or '?')
            section = section + 1
        print '</ul><hr>'
        section = 0                                          # make details
        for key in keys:
            html = '<h2><a name="#S%d">Key = "%s"</a></h2><hr>' 
            print html % (section, cgi.escape(str(key)))
            for record in index[key]:
                generateRecord(record)
            section = section + 1

