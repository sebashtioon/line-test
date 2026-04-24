extends Node

enum GameState {MAINMENU, NORMAL}
var game_state : GameState
enum PlayerMouseState {SLOW, NORMAL}
var player_mouse_state : PlayerMouseState = PlayerMouseState.NORMAL

var player : CharacterBody3D
var world : Node3D
