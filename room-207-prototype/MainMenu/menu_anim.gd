extends Node

var tween:Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	titleLabel()

func titleLabel() -> void:
	if tween: tween.kill()
	
	tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_loops()
	tween.tween_property(%Room207, "position:y", -10, 2.0)
	tween.tween_property(%Room207, "position:y", 10, 2.0)
