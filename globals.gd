extends Node

var level: int = 0

@warning_ignore("unused_signal")
signal update_level ## arg1: int = level_destination

@warning_ignore("unused_signal")
signal update_level_text ## arg1: int = level

@warning_ignore("unused_signal")
signal update_player_state ## arg1: bool = should_enable

@warning_ignore("unused_signal")
signal update_player_position ## arg1: CanvasLayer = current_level

@warning_ignore("unused_signal")
signal activation_area_entered ## arg1: Area2D

@warning_ignore("unused_signal")
signal activation_area_exited ## arg1: Area2D, arg2: String = "Activation Text"
