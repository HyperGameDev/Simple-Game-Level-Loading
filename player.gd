class_name Player extends CharacterBody2D

@onready var player_area: Area2D = %Area2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var starting_position: Vector2

var player_state: player_states
enum player_states {
	DISABLED,
	ENABLED
}

var door_id_seen: int = 0
var level_destination_seen: int

var player_door_state: player_door_states
enum player_door_states {
	NOT_AT_DOOR,
	IS_AT_DOOR
}

func _ready() -> void:
	starting_position = global_position
	
	player_area.area_entered.connect(_on_area_entered)
	player_area.area_exited.connect(_on_area_exited)
	
	Globals.update_player_state.connect(_on_update_player_state)
	Globals.update_player_position.connect(_on_update_player_position)

func _physics_process(delta: float) -> void:
	if player_state == player_states.ENABLED:
		player_movement(delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Activate"):
		if player_door_state == player_door_states.IS_AT_DOOR:
			Globals.update_level.emit(level_destination_seen)
			
func _on_area_entered(area):
	if area is Door:
		player_overlaps_door(area,true)
	
func _on_area_exited(area):
	if area is Door:
		player_overlaps_door(area,false)
		
func player_overlaps_door(door,is_entered):
	if is_entered:
		player_door_state = player_door_states.IS_AT_DOOR
		
		door_id_seen = door.door_id
		level_destination_seen = door.level_destination
		
		Globals.activation_area_entered.emit(door,"Open (E)")
		
	else:
		if door_id_seen == door.door_id: ## Ensures player can't exit a door they haven't entered yet
			player_door_state = player_door_states.NOT_AT_DOOR
			
			Globals.activation_area_exited.emit()

func _on_update_player_state(should_enable) -> void:
	if should_enable:
		visible = true
		set_collision_layer_value(1,true)
		process_mode = PROCESS_MODE_INHERIT
		player_state = player_states.ENABLED
	
	else:
		visible = false
		set_collision_layer_value(1,false)
		process_mode = PROCESS_MODE_DISABLED
		player_state = player_states.DISABLED

func _on_update_player_position(current_level) -> void:
	
	for node in current_level.get_children():
		if node is Door:
			if node.door_id == door_id_seen:
				global_position = node.global_position

func player_movement(delta) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
