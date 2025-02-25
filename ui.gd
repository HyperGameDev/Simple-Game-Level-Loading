class_name UIManager extends Node

@onready var label_level: Label = %Label_Level

@onready var control_activate: Control = %Control_Activate
@onready var label_activate: Label = %Label_Activate

func _ready() -> void:
	Globals.update_level_text.connect(_on_update_level_text)
	
	Globals.activation_area_entered.connect(_on_activation_area_entered)
	Globals.activation_area_exited.connect(_on_activation_area_exited)


func _on_update_level_text(level):
	label_level.text = "Level " + str(level)
	
func _on_activation_area_entered(area,activation_text):
	label_activate.text = activation_text
	label_activate.visible = true
	for node in area.get_children():
		if node is Marker2D:
			control_activate.global_position = node.global_position
	
func _on_activation_area_exited():
	label_activate.visible = false
		
