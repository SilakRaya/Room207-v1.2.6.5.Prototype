extends CharacterBody2D

const SPEED = 500.0
const GRAVITY = 980.0

func _ready() -> void:
	add_to_group("player")

func _physics_process(delta: float) -> void:
	# Apply gravity constantly
	velocity.y += GRAVITY * delta
	
	# Handle horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
