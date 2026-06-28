extends Node

enum GameState {MAINMENU, NORMAL}
enum PlayerLoc {MAINROOM, HALLWAY}
var player_location : PlayerLoc
var game_state : GameState
enum PlayerMouseState {SLOW, NORMAL}
var player_mouse_state : PlayerMouseState = PlayerMouseState.NORMAL

var player : CharacterBody3D
var world : Node3D
