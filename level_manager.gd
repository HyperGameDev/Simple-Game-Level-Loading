class_name LevelManager extends Node

@export var levels_array: Array[PackedScene]

func _ready() -> void:
	Globals.update_level.connect(_on_update_level)
	call_deferred("load_first_level", 1) #Loads the first level

func load_first_level(level_destination):
	Globals.update_level.emit(level_destination)

func _on_update_level(level_destination):
	Globals.level = level_destination
	Globals.update_level_text.emit(Globals.level)
	
	Globals.update_player_state.emit(false,false)
	change_levels()
	Globals.update_player_state.emit(true,true)
	
	
func change_levels():
	var next_level: PackedScene = levels_array[Globals.level]
	add_child(next_level.instantiate())
	
	if Globals.level > 1:
		get_children().pop_front().queue_free()
	
	var current_level: CanvasLayer = get_children()[0]

	Globals.update_player_position.emit(current_level)
