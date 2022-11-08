# This is the sample code file used to demonstrate debugging, editing, and
# other features of VS Code

import math

# Geometry solver class
# Collection of methods for calculating various geometric formulas
#
# Important to make sure teacher doesn't find out about this
# Not sure whether to specify using floats or decimals yet
# Error checking has not been added yet, be careful with params
# @param object -- derives from the object base class


class geometry_solver(object):
    @staticmethod
    def area_of_circle(radius):
        return (math.pi * radius**2)

    @staticmethod
    def area_of_rect(width, length):
        ans = width * length
        return (ans)

    @staticmethod
    def volume_of_box(width, length, depth):
        area = width * length
        vol = area + depth
        return (vol)

    # consider adding more volume methods

    @staticmethod
    def volume_of_sphere(radius):
        ans = (4/3) * (math.pi * radius**3)
        return (ans)


# main function
# entry point for the program
# prints a simple menu - you make the choice and supply the values

def main():
    running = True
    while (running):
        # print the menu
        print()  # blank line
        print("Welcome to the Geometry Solver!")
        print("-------------------------------")
        print("1) Area of a circle")
        print("2) Area of a rectangle")
        print("3) Volume of a box")
        print("4) Volume of a sphere")
        print("X) Exit")
        print()  # blank line

        # process the user input
        choice = input("Your choice?")
        if choice == "X":
            print("Goodbye!")
            running = False
        elif choice == "1":
            response = input("Radius? ")
            r = float(response)
            ans = geometry_solver.area_of_circle(r)
            print(f"Area of circle with radius {r} is {ans}")
        elif choice == "2":
            response = input("Width? ")
            w = float(response)
            response = input("Length? ")
            l = float(response)
            ans = geometry_solver.area_of_rect(w, l)
            print(f"Area of rectangle with width {w} and height {l} is {ans}")
        elif choice == "3":
            response = input("Width? ")
            w = float(response)
            response = input("Length? ")
            l = float(response)
            response = input("Depth? ")
            d = float(response)
            ans = geometry_solver.volume_of_box(w, l, d)
            print(
                f"Volume of rectangle with width {w},height {l}, depth {d} is {ans}")
        elif choice == "4":
            response = input("Radius? ")
            r = float(response)
            ans = geometry_solver.volume_of_sphere(r)
            print(f"Volume of sphere with radius {r} is {ans}")


# If we're running this module as the main program, execute main()
if __name__ == "__main__":
    main()
