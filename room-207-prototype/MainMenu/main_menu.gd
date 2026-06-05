extends Control

var FADE_IN_FINISHED : bool = false

func _ready() -> void:
	if not FADE_IN_FINISHED:
		$ColorRect.visible = true
		$AnimationPlayer.play("FadeIn")
	

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/options.tscn")


func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/credits.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Ep1/Scenes/SceneA1.tscn")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "FadeIn":
		$ColorRect.visible = false
		FADE_IN_FINISHED = true
