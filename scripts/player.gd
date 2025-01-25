extends CharacterBody2D


@onready var timer: Timer = $"Jump buffer"
@onready var coyote: Timer = $Coyote
@export var speed = 300.0
@export var jump_velocity = -500.0
var can_jump : bool
var can_coyote : bool
var jump_counter := 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	velocity += get_gravity() * delta
	
	# Handle jump.
	jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("player1_left", "player1_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func jump() :
	if not is_on_floor() and Input.is_action_just_pressed("player1_jump") :
		if jump_counter > 0 and (not can_coyote) :
			velocity.y = jump_velocity
			jump_counter -= 1
		else :
			timer.start()
			can_jump = true
	if is_on_floor() :
		jump_counter = 1
		coyote.start()
		can_coyote = true
	if can_coyote and can_jump :
		velocity.y = jump_velocity
		jump_counter = 1
	if (Input.is_action_just_pressed("player1_jump") or can_jump) and is_on_floor():
		velocity.y = jump_velocity


func _on_timer_timeout() -> void:
	can_jump = false


func _on_coyote_timeout() -> void:
	can_coyote = false
