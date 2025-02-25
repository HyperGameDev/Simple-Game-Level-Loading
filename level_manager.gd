class_name LevelManager extends Node

@export var levels_array: Array[PackedScene]
var game_begun: bool = false

func _ready() -> void:
	Globals.update_level.connect(_on_update_level)
	call_deferred("load_first_level", 1) #Loads the first level

func load_first_level(level_destination):
	Globals.update_level.emit(level_destination)
	game_begun = true

func _on_update_level(level_destination):
	Globals.level = level_destination
	Globals.update_level_text.emit(Globals.level)
	
	Globals.update_player_state.emit(false) ##Disable Player
	change_levels()
	Globals.update_player_state.emit(true) ##Enable Player
	
func change_levels():
	var next_level: PackedScene = levels_array[Globals.level]
	var current_level: CanvasLayer = next_level.instantiate()
	add_child(current_level)
	
	if game_begun:
		get_children().pop_front().queue_free()
	else:
		Globals.update_player_state.emit(true) ##Enable Player

	Globals.update_player_position.emit(current_level)
