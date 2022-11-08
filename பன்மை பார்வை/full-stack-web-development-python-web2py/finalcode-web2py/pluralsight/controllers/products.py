# -*- coding: utf-8 -*-
# try something like
def index(): return dict(message="hello from products.py")

def admin_view():
    sql = "SELECT products.id, products.product_name, orders.order_price, orders.order_date "
    sql = sql + "FROM products inner join orders on products.id = orders.product_id;"
    rows = db.executesql(sql)
    return locals()

def admin_view1():
    userdict = {}
    userrows = db(db.auth_user).select()
    for x in userrows:
        userdict[x.id] = x.first_name + " " + x.last_name
    sql = "SELECT products.id, products.product_name, orders.order_price, "
    sql = sql + "orders.order_date,   orders.orderer_id "
    sql = sql + "FROM products inner join orders on products.id = orders.product_id;"
    rows = db.executesql(sql)
    return locals()
