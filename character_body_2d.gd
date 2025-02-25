class_name Player extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var player_state: player_states
enum player_states {
	DISABLED,
	ENABLED
}

var door_id_seen: int
var level_destination_seen: int

var player_door_state: player_door_states
enum player_door_states {
	NOT_AT_DOOR,
	IS_AT_DOOR
}

func _ready() -> void:
	Globals.update_player_state.connect(_on_update_player_state)
	Globals.update_player_position.connect(_on_update_player_position)

func _physics_process(delta: float) -> void:
	if player_state == player_states.ENABLED:
		player_movement(delta)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Activate"):
		if player_door_state == player_door_states.IS_AT_DOOR:
			Globals.update_level.emit(level_destination_seen)
	
func _on_update_player_state(should_enable,teleport_to_door):
	if should_enable:
		visible = true
		process_mode = PROCESS_MODE_INHERIT
		player_state = player_states.ENABLED
	
	else:
		visible = false
		process_mode = PROCESS_MODE_DISABLED
		player_state = player_states.DISABLED


func _on_update_player_position(current_level):
	for node in current_level.get_children():
		if node.name == "Door":
			global_position


func player_movement(delta):
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
