extends Node2D

var offset_MAX : int = 0
var offset_BASE : int = 0
var finished : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not finished:
		if offset_MAX < 0:
			offset_BASE += 1
			%Door.position.x = offset_BASE
		if (offset_BASE == offset_MAX):
			finished = true


func _on_a_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		offset_MAX = 508


func _on_a_2_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_a_3_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_a_4_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.
