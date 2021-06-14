#!/usr/bin/env python3
# bwDB - CRUD library for sqlite 3
#அச்சிடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.
def அச்சிடு(*வாதங்கள்,பிரி=" ",முடி='\n',கோப்பு=None,பறிப்பு=False):
    print(*வாதங்கள், sep=பிரி,end=முடி, file=கோப்பு,flush=பறிப்பு)
    
# உள்ளீடு வரையறு - பின் வரும் நிரல்களில் அச்சிடு பயன்படுத்தலாம்.    
def உள்ளீடு(*வாதங்கள்):
    அ = input (*வாதங்கள்)
    return அ

import sqlite3

__version__ = '1.2.0'

class bwDB:
    def __init__(சுய, **kwargs):
        """
            db = bwDB ([அட்டவணை = ''] [, கோப்புபெயர் = ''])
             கட்டமைப்பாளர் முறை
                 அட்டவணை CRUD முறைகளுக்கானது
                 கோப்புபெயர் தரவுத்தள கோப்புடன் இணைப்பதாகும்
        """
        # see filename @property decorators below
        சுய._filename = kwargs.get('filename')
        சுய._table = kwargs.get('table', '')

    def set_table(சுய, tablename):
        சுய._table = tablename

    def sql_do(சுய, sql, params=()):
        """
            db.sql_do( sql[, params] )
            method for non-select queries
                sql is string containing SQL
                params is list containing parameters
            returns nothing
        """
        சுய._db.execute(sql, params)
        சுய._db.commit()

    def sql_do_nocommit(சுய, sql, params=()):
        """
            sql_do_nocommit( sql[, params] )
            method for non-select queries *without commit*
                sql is string containing SQL
                params is list containing parameters
            returns nothing
        """
        சுய._db.execute(sql, params)

    def sql_query(சுய, sql, params=()):
        """
            db.sql_query( sql[, params] )
            generator method for queries
                sql is string containing SQL
                params is list containing parameters
            returns a generator with one row per iteration
            each row is a Row factory
        """
        c = சுய._db.execute(sql, params)
        for r in c:
            yield r

    def sql_query_row(சுய, sql, params=()):
        """
            db.sql_query_row( sql[, params] )
            query for a single row
                sql is string containing SQL
                params is list containing parameters
            returns a single row as a Row factory
        """
        c = சுய._db.execute(sql, params)
        return c.fetchone()

    def sql_query_value(சுய, sql, params=()):
        """
            db.sql_query_row( sql[, params] )
            query for a single value
                sql is string containing SQL
                params is list containing parameters
            returns a single value
        """
        c = சுய._db.execute(sql, params)
        return c.fetchone()[0]

    def commit(சுய):
        சுய._db.commit()

    def getrec(சுய, recid):
        """
            db.getrec(recid)
            get a single row, by id
        """
        query = f'SELECT * FROM {சுய._table} WHERE id = ?'
        c = சுய._db.execute(query, (recid,))
        return c.fetchone()

    def getrecs(சுய):
        """
            db.getrecs()
            get all rows, returns a generator of Row factories
        """
        query = f'SELECT * FROM {சுய._table}'
        c = சுய._db.execute(query)
        for r in c:
            yield r

    def insert_nocommit(சுய, rec):
        """
            db.insert(rec)
            insert a single record into the table
                rec is a dict with key/value pairs corresponding to table schema
            omit id column to let SQLite generate it
        """
        klist = sorted(rec.keys())
        values = [rec[v] for v in klist]  # a list of values ordered by key
        q = 'INSERT INTO {} ({}) VALUES ({})'.format(
            சுய._table,
            ', '.join(klist),
            ', '.join('?' * len(values))
        )
        c = சுய._db.execute(q, values)
        return c.lastrowid

    def insert(சுய, rec):
        lastrowid = சுய.insert_nocommit(rec)
        சுய._db.commit()
        return lastrowid

    def update_nocommit(சுய, recid, rec):
        """
            db.update(id, rec)
            update a row in the table
                id is the value of the id column for the row to be updated
                rec is a dict with key/value pairs corresponding to table schema
        """
        klist = sorted(rec.keys())
        values = [rec[v] for v in klist]  # a list of values ordered by key

        for i, k in enumerate(klist):  # don't udpate id
            if k == 'id':
                del klist[i]
                del values[i]

        q = 'UPDATE {} SET {} WHERE id = ?'.format(
            சுய._table,
            ',  '.join(map(lambda s: '{} = ?'.format(s), klist))
        )
        சுய._db.execute(q, values + [recid])

    def update(சுய, recid, rec):
        சுய.update_nocommit(recid, rec)
        சுய._db.commit()

    def delete_nocommit(சுய, recid):
        """
            db.delete(recid)
            delete a row from the table, by recid
        """
        query = f'DELETE FROM {சுய._table} WHERE id = ?'
        சுய._db.execute(query, [recid])

    def delete(சுய, recid):
        சுய.delete_nocommit(recid)
        சுய._db.commit()

    def countrecs(சுய):
        """
            db.countrecs()
            count the records in the table
            returns a single integer value
        """
        query = f'SELECT COUNT(*) FROM {சுய._table}'
        c = சுய._db.execute(query)
        return c.fetchone()[0]

    # filename property
    @property
    def _filename(சுய):
        return சுய._dbfilename

    @_filename.setter
    def _filename(சுய, fn):
        சுய._dbfilename = fn
        சுய._db = sqlite3.connect(fn)
        சுய._db.row_factory = sqlite3.Row

    @_filename.deleter
    def _filename(சுய):
        சுய.close()

    def close(சுய):
        சுய._db.close()
        del சுய._dbfilename


def test():
    fn = ':memory:'  # in-memory database
    t = 'foo'

    recs = [
        dict(string='one', number=42),
        dict(string='two', number=73),
        dict(string='three', number=123)
    ]

    # -- for file-based database
    # try: os.stat(fn)
    # except: pass
    # else: 
    #     அச்சிடு('Delete', fn)
    #     os.unlink(fn)

    அச்சிடு('bwDB version', __version__)

    அச்சிடு(f'Create database file {fn} ...', முடி='')
    db = bwDB(filename=fn, table=t)
    அச்சிடு('Done.')

    அச்சிடு('Create table ... ', முடி='')
    db.sql_do(f' DROP TABLE IF EXISTS {t} ')
    db.sql_do(f' CREATE TABLE {t} ( id INTEGER PRIMARY KEY, string TEXT, number INTEGER ) ')
    அச்சிடு('Done.')

    அச்சிடு('Insert into table ... ', முடி='')
    for r in recs:
        db.insert(r)
    அச்சிடு('Done.')

    அச்சிடு(f'There are {db.countrecs()} rows')

    அச்சிடு('Read from table')
    for r in db.getrecs():
        அச்சிடு(dict(r))

    அச்சிடு('Update table')
    db.update(2, dict(string='TWO'))
    அச்சிடு(dict(db.getrec(2)))

    அச்சிடு('Insert an extra row ... ', முடி='')
    newid = db.insert({'string': 'extra', 'number': 512})
    அச்சிடு(f'(id is {newid})')
    அச்சிடு(dict(db.getrec(newid)))
    அச்சிடு(f'There are {db.countrecs()} rows')
    அச்சிடு('Now delete it')
    db.delete(newid)
    அச்சிடு(f'There are {db.countrecs()} rows')
    for r in db.getrecs():
        அச்சிடு(dict(r))
    for r in db.sql_query(f"select * from {t}"):
        அச்சிடு(r)
    db.close()


if __name__ == "__main__": test()
