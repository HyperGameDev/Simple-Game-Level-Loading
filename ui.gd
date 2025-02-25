class_name UIManager extends Node

@onready var label_level: Label = %Label_Level

func _ready() -> void:
	print("UI ready")
	Globals.update_level_text.connect(_on_update_level_text)

func _on_update_level_text(level):
	label_level.text = "Level " + str(level)
