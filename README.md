[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/syDSSnTt)
# APCS2 Final Project
## Group Info
### Max Zabranov
### Suhana Kumar
### Group Name: Rabid Rabbits

## Overview
Our project is a tower defense game called Rabid Rabbits where you have to strategically place different types of hunters (towers) in order to prevent the waves of rabbits from eaching the end of the path. You will have to manage your resources and decide where to place and upgrade your towers to survive the progressively increasing waves. As the waves increase, more rabbits appear with more health and speed, along with other types of rabbits such as fast and tank rabbits. You can choose and place different towers that will aid you in defeating the rabbits, with towers like the slow and multi hit towers. Can you make it to the final wave and beat the giant boss rabbit to beat the game? Play and find out.

## Instructions
You can run the Game sketch folder through terminal, which will run the game without loading the processing editor (Command is /usr/local/processing-4.3/processing-java --sketch=Game --run). 
##
You can also open the processing editor for one of the pde files in the folder and press the run button on top.

### Downloading "Sound" from Libraries is necessary to run.

When you run the game, you are greeted with a map select screen. "Grassy Meadows" is the easy map, "Sandy Shores" is the medium map, and "Lava Lake" is the hard map. Each difficulty has a different health and speed multiplier and max waves (Hard: 4x speed, 2x health, 30 waves, Medium: 1.5x speed, 2x health, 20 waves Easy: 1x speed, 1x health, 15 waves). After selecting a map, a menu is shown on the right side of the screen that displays your health, money, wave, and towers. Click a tower button on the right to place a certain tower anywhere on the map except the path if you have enough money. After a tower is placed, you can click on it and press space to upgrade it, which will increase stats depending on the tower, but you need to have enough money to upgrade. Once you beat the boss that spawns on the max wave of the map, a message will say "You Win." If you lose all your health, a message comes up and says "Game Over." The restart button resets the game and the maps button take you back to the map select screen. If you win or lose, you need to restart the game to play again.

### Keybinds

left click - places tower or gives upgrade tower option (depends on whether tower is already placed) 
##
q - cancels tower placement (must have already clicked on a tower button) 
##
m - gives 1000 money
##
r - spawns 1 rabbit 
##
f - spawns 1 fast rabbit 
##
t - spawns 1 tank rabbit
##
b - spawns 1 boss rabbit 
##
w - skips 1 wave 
##
space - upgrades tower (tower must already be selected to upgrade)

### File Link

https://drive.google.com/file/d/1PSk8gxLcBjOmwNEMZoDF8T9_byMR9Zqa/view?usp=sharing

### Bugs
When you lose or win, you have to close the game window and run it again to restart 
##
If the boss rabbit makes it to the end on the final wave and you have enough health, it says "You win" instead of "Game Over"
