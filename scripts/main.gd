extends Node2D

var speed = 400
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	for i in range(number_of_bodies):
		spawn_rigid_body()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for i in range(number_of_bodies):
		spawn_array[i].po
		

@onready var rigid_body_scene : StaticBody2D = $bubble


@export var number_of_bodies: int = 50
@export var spawn_range: Vector2 = Vector2(600, 600)
var spawn_array : <StaticBody2D>[] = []


func spawn_rigid_body():
	if not rigid_body_scene:
		return
	var instance : StaticBody2D = rigid_body_scene.duplicate()
	var bubble_instance_position :=Vector2(
		randi_range(-spawn_range.x,spawn_range.x),
		randi_range(-spawn_range.y,spawn_range.y)
	)	 
	instance.position = bubble_instance_position
	spawn_array.append(instance)
	add_child(instance)
	


func _on_timer_timeout() -> void:
	spawn_rigid_body()
