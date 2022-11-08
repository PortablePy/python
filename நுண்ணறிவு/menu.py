class Dish:
    def __init__(self, name, preparation_time, dish_type):
        self.name = name
        self.preparation_time = preparation_time
        self.dish_type = dish_type

    def __lt__(self,other):
        return self.preparation_time < other.preparation_time
    
    def __le__(self,other):
        return self.preparation_time <= other.preparation_time
    
    def __gt__(self,other):
        return self.preparation_time > other.preparation_time
    
    def __ge__(self,other):
        return self.preparation_time >= other.preparation_time
    
    def __eq__(self,other):
        return self.preparation_time == other.preparation_time
    
    def __ne__(self,other):
        return self.preparation_time != other.preparation_time
        
    def __repr__(self):
        return self.name


class Menu:
    def __init__(self, name):
        self.name = name
        self.dishes = []
    
    def add_dish(self, dish):
        self.dishes.append(dish)
        
    def get_starters(self):
        starters = [d for d in self.dishes if d.dish_type == "starter" ]
        return starters
    
    def get_dishes(self):
        dishes = [ d for d in self.dishes if d.dish_type == "dish" ]
        return dishes
    
    def get_desserts(self):
        desserts = [d for d in self.dishes if d.dish_type == "dessert" ]
        return desserts
    
    def get_minimum_preparation_time(self):
        pt_s= [d.preparation_time for d in self.get_starters()]
        pt_di= [d.preparation_time for d in self.get_dishes() ]
        pt_de= [d.preparation_time for d in self.get_desserts()]
        a=0
        if pt_s:
            a = min(pt_s)
        b =0
        if pt_di:
            b = min(pt_di)
        c = 0
        if pt_de:
            c= min(pt_de)
        return a + b + c
        
    
    def get_maximum_preparation_time(self):
        pt_s= [d.preparation_time for d in self.get_starters()]
        pt_di= [d.preparation_time for d in self.get_dishes() ]
        pt_de= [d.preparation_time for d in self.get_desserts()]
        a=0
        if pt_s:
            a = max(pt_s)
        b =0
        if pt_di:
            b = max(pt_di)
        c = 0
        if pt_de:
            c= max(pt_de)
        return a + b + c
     

    def __add__(self, other):
        name = self.name +" & " +other.name
        dishes = self.dishes + other.dishes
        new_menu = Menu(name)
        for d in dishes:
            new_menu.add_dish(d)
        return new_menu

    def __repr__(self):
        out = "STARTER\n"
        for d in sorted(self.get_starters()):
            out += str(d)+ "\n"
        out += "\nDISH\n"
        for d in sorted(self.get_dishes()):
            out += str(d) +"\n"
        out += "\nDESSERT\n"
        for d in sorted(self.get_desserts()):
            out += str(d)+"\n"
        return out

