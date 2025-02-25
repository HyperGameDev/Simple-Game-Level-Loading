class_name Door extends Area2D

@export var door_id: int = 0
@export var level_destination: int = 0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body is Player:
		body.player_door_state = body.player_door_states.IS_AT_DOOR
		body.door_id_seen = door_id
		body.level_destination_seen = level_destination
		
