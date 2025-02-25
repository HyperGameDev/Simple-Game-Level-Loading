class_name Door extends Area2D

@onready var label_level: Label = %Label_Level
@onready var label_activate: Label = %Label_Activate

@export var door_id: int = 0
@export var level_destination: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	label_level.text = str(level_destination)
	
func _on_body_entered(body):
	if body is Player:
		label_activate.visible = true
		
		body.player_door_state = body.player_door_states.IS_AT_DOOR
		body.door_id_seen = door_id
		body.level_destination_seen = level_destination
		print("Player Entered Door ",door_id)
		
func _on_body_exited(body):
	if body is Player:
		label_activate.visible = false
		
		body.player_door_state = Player.player_door_states.NOT_AT_DOOR
		print("Player Exited Door ",door_id)
		
