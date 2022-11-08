"""Kafka - the adventure game you cannot win."""





def play():

    position = (0, 0)
    alive = True

    while position:

        locations = {
            (0, 0): lambda: print("You are in a maze of twisty passages, all alike."),
            (1, 0): lambda: print("You are on a road in a dark forest. To the north you can see a tower."),
            (1, 1): lambda: print("There is a tall tower here, with no obvious door. A path leads east."),
        }

        try:
            location_action = locations[position]
        except KeyError:
            print("There is nothing here.")
        else:
            location_action()

        command = input("? ")

        actions = {
            "N": go_north,
            "E": go_east,
            "W": go_west,
            "S": go_south,
            "L": look,
            "Q": quit_game,
        }

        try:
            command_action = actions[command]
        except KeyError:
            print("I don't understand")
        else:
            position = command_action(position)

    print("Game over")

if __name__ == '__main__':
    play()
