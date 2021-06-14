#!/usr/bin/env python3
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import sqlite3

def முதன்மை ():
    அச்சிடு('connect')
    db = sqlite3.connect('db-api.db')
    cur = db.cursor()
    அச்சிடு('create')
    cur.execute("DROP TABLE IF EXISTS test")
    cur.execute("""
        CREATE TABLE test (
            id INTEGER PRIMARY KEY, string TEXT, number INTEGER
        )
        """)
    அச்சிடு('insert row')
    cur.execute("""
        INSERT INTO test (string, number) VALUES ('one', 1)
        """)
    அச்சிடு('insert row')
    cur.execute("""
        INSERT INTO test (string, number) VALUES ('two', 2)
        """)
    அச்சிடு('insert row')
    cur.execute("""
        INSERT INTO test (string, number) VALUES ('three', 3)
        """)
    அச்சிடு('commit')
    db.commit()
    அச்சிடு('count')
    cur.execute("SELECT COUNT(*) FROM test")
    count = cur.fetchone()[0]
    அச்சிடு(f'there are {count} rows in the table.')
    அச்சிடு('read')
    for row in cur.execute("SELECT * FROM test"):
        அச்சிடு(row)
    அச்சிடு('drop')
    cur.execute("DROP TABLE test")
    அச்சிடு('close')
    db.close()

if __name__ == '__main__': முதன்மை ()
