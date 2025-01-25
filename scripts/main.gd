extends Node2D

var speed = 3.75

@onready var rigid_body_scene: StaticBody2D = $bubble

@export var number_of_bodies: int = 20
@export var spawn_range: Vector2 = Vector2(600, 600)
var spawn_array: Array[StaticBody2D] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for i in range(number_of_bodies):
		spawn_rigid_body()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(len(spawn_array)):
		spawn_array[i].position.y += speed

func spawn_rigid_body():
	if not rigid_body_scene:
		return
	
	var max_attempts = 10
	var attempts = 0
	var valid_position = false
	var bubble_instance_position = Vector2()

	# Try to find a non-overlapping position
	while not valid_position and attempts < max_attempts:
		bubble_instance_position = Vector2(
			randi_range(-spawn_range.x, spawn_range.x),
			randi_range(-spawn_range.y, spawn_range.y)
		)
		valid_position = is_valid_position(bubble_instance_position)
		attempts += 1

	if valid_position:
		var instance: StaticBody2D = rigid_body_scene.duplicate()
		instance.position = bubble_instance_position
		spawn_array.append(instance)
		add_child(instance)

func spawn_rigid_body_game():
	if not rigid_body_scene:
		return

	var max_attempts = 10
	var attempts = 0
	var valid_position = false
	var bubble_instance_position = Vector2()

	while not valid_position and attempts < max_attempts:
		bubble_instance_position = Vector2(
			randi_range(-spawn_range.x, spawn_range.x),
			randi_range(-600, -500)
		)
		valid_position = is_valid_position(bubble_instance_position)
		attempts += 1

	if valid_position:
		var instance: StaticBody2D = rigid_body_scene.duplicate()
		instance.position = bubble_instance_position
		spawn_array.append(instance)
		add_child(instance)

func is_valid_position(position: Vector2) -> bool:
	for existing_instance in spawn_array:
		if existing_instance.position.distance_to(position) < 200:  
			return false
	return true

func _on_timer_timeout() -> void:
	for i in range(5):
		spawn_rigid_body_game()
