extends Node

@onready var player: Player = %Player
@onready var marker_start_point: Marker2D = %Marker_StartPoint

func _ready() -> void:
	player.global_position = marker_start_point.global_position
