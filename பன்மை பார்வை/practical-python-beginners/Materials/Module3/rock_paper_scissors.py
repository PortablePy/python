computer_choice = 'scissors'

user_choice = input("Do you want - rock, paper, or scissors?\n")

if computer_choice == user_choice:
    print('TIE')
elif user_choice == 'rock' and computer_choice == 'scissors':
    print('WIN')
elif user_choice == 'paper' and computer_choice == 'rock':
    print('WIN')
elif user_choice == 'scissors' and computer_choice == 'paper':
    print('WIN')
else:
    print('You lose :( Computer wins :D')