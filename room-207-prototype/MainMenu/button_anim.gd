extends Node

var tween:Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	setup_button_pivots()

func setup_button_pivots() -> void:
	var buttons = [%NewGame,%Options,%Credits,%Exit]
	for button in buttons:
		#button.anchor_left = 0.5
		#button.anchor_right = 0.5
		#button.anchor_top = 0.5
		#button.anchor_bottom = 0.5
		button.pivot_offset = button.size / 2
	

func _on_new_game_mouse_entered() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%NewGame, "scale", Vector2(1.2, 1.2), 0.5)
	 
func _on_new_game_mouse_exited() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%NewGame, "scale", Vector2(1.0, 1.0), 0.3)


func _on_options_mouse_entered() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%Options, "scale", Vector2(1.2, 1.2), 0.5)


func _on_options_mouse_exited() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%Options, "scale", Vector2(1.0, 1.0), 0.3)


func _on_credits_mouse_entered() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%Credits, "scale", Vector2(1.2, 1.2), 0.5)


func _on_credits_mouse_exited() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%Credits, "scale", Vector2(1.0, 1.0), 0.3)


func _on_exit_mouse_entered() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%Exit, "scale", Vector2(1.2, 1.2), 0.5)


func _on_exit_mouse_exited() -> void:
	if tween: tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_QUINT)
	tween.tween_property(%Exit, "scale", Vector2(1.0, 1.0), 0.3)
