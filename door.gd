class_name Door extends Area2D

@onready var label_level: Label = %Label_Level

@export var door_id: int = 0
@export var level_destination: int = 0

func _ready() -> void:
	label_level.text = str(level_destination)
