extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("Intro")
	

# This is the skip button
func _on_skip_button_pressed() -> void:
	if $AnimationPlayer.current_animation == "Intro":
		$AnimationPlayer.stop()
		$IntroContainer.visible = false
		$MainMenuContainer.visible = true
		$AnimationPlayer.play("MainMenu")
	print("Pressed")

# This is the new game button
func _on_new_game_pressed() -> void:
	$MainMenuContainer.visible = false
	$EpisodeSelection.visible = true
	print("New Game Pressed")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Intro":
		$AnimationPlayer.play("MainMenu")
		
# Back button pressed
func _on_back_pressed() -> void:
	%EpisodeSelection.visible = false
	$MainMenuContainer.visible = true

# Episode One
# call the EpisodeTitle & EpisodeDesc
func _on_episode_one_pressed() -> void:
	%EpisodeTitle.text = "All I Feel And See"
	%EpisodeDesc.text = "Explore and identify the mystery of Room 207"

# Exit button
func _on_exit_pressed() -> void:
	get_tree().quit()

# Credits
func _on_credits_pressed() -> void:
	$MainMenuContainer.visible = false
	$Credits.visible = true
	$AnimationPlayer.play("Credits")
	%Back2.visible = true


func _on_back_2_pressed() -> void:
	$Credits.visible = false
	$AnimationPlayer.stop()
	%EpisodeSelection.visible = false
	$MainMenuContainer.visible = true
	%Back2.visible = false
