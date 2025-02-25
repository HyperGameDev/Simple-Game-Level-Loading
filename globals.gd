extends Node

var level: int = 0

@warning_ignore("unused_signal")
signal update_level ##arg1: int = level_destination

@warning_ignore("unused_signal")
signal update_level_text ##arg1: int = level

@warning_ignore("unused_signal")
signal update_player_state ##arg1: bool = should_enable, ##arg2: bool = teleport_to_door



@warning_ignore("unused_signal")
signal update_player_position ##arg1: CanvasLayer = current_level
