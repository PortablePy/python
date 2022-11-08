"""Kafka - the adventure game you cannot win."""


def go_north(position):
    i, j = position
    new_position = (i, j + 1)
    return new_position


def go_east(position):
    i, j = position
    new_position = (i + 1, j)
    return new_position


def go_south(position):
    i, j = position
    new_position = (i, j - 1)
    return new_position


def go_west(position):
    i, j = position
    new_position = (i - 1, j)
    return new_position


def look(position):
    return position


def quit_game(position):
    return None


def play():

    position = (0, 0)
    alive = True

    while position:

        locations = {
            (0, 0): labyrinth,
            (1, 0): dark_forest_road,
            (1, 1): tall_tower,
            (2, 1): rabbit_hole,
        }

        try:
            location_action = locations[position]
        except KeyError:
            print("There is nothing here.")
        else:
            position, alive = location_action(position, alive)

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
