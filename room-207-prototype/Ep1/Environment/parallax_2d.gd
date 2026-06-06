extends Parallax2D

@export var player: Node2D  # Drag your player node here
@export var max_offset: float = 8.0  # Max shift in pixels
@export var sensitivity: float = 0.5  # How much player movement affects offset

var original_position: Vector2
var left_limit_reached: bool = false
var right_limit_reached: bool = false

func _ready():
	original_position = position
	if not player:
		player = get_node("res://Ep1/Characters/Jolina.tscn")  # Adjust path as needed

func _process(delta):
	if not player:
		return
	
	# Calculate offset based on player's horizontal position
	# Assuming player starts at 0, or track their relative movement
	var player_x = player.global_position.x
	var target_offset = clamp(player_x * sensitivity, -max_offset, max_offset)
	
	# Apply to this node's position
	position.x = original_position.x + target_offset
	
	# Optional: Smooth the movement
	# position.x = lerp(position.x, original_position.x + target_offset, 0.3)
