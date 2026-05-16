extends Control

@onready var new_game_button = $NewGame
@onready var options_button = $Options
@onready var credits_button = $Credits
var characterSelects = ""

func _ready():
	print("NewGame button found: ", new_game_button != null)
	print("Options button found: ", options_button != null)
	print("Credits button found: ", credits_button != null)

	# Connect signals
	if new_game_button:
		new_game_button.pressed.connect(_on_new_game_pressed)
	else:
		push_error("NewGame button not found! Check node name.")
	
	if options_button:
		options_button.pressed.connect(_on_options_pressed)
	else:
		push_error("Options button not found! Check node name.")
	
	if credits_button:
		credits_button.pressed.connect(_on_credits_pressed)
	else:
		push_error("Credits button not found! Check node name.")

func _on_new_game_pressed():
	$AnimationPlayer.play("NewGame")
	print("New Game button pressed")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Main-Menu/Options.tscn")
	print("Options button pressed")

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://Main-Menu/Credits.tscn")
	print("Credits button pressed")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_marvin_pressed() -> void:
	characterSelects = "Marvin"
	$AnimationPlayer.play("EpisodeSelect")

func _on_jolina_pressed() -> void:
	characterSelects = "Jolina"
	$AnimationPlayer.play("EpisodeSelect")

func _on_episode_one_pressed() -> void:
	$AnimationPlayer.play("eraseTransition")
	await $AnimationPlayer.animation_finished
	match characterSelects:
		"Jolina":
			print("Jolina selected")
			get_tree().change_scene_to_file("res://EpisodeOne/EpOneJolina.tscn")
			
		"Marvin":
			print("Marvin selected")
			get_tree().change_scene_to_file("res://EpisodeOne/EpOneMarvin.tscn")
			


func _on_episode_two_pressed() -> void:
	$AnimationPlayer.play("eraseTransition")
	await $AnimationPlayer.animation_finished
	match characterSelects:
		"Jolina":
			print("Jolina selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")
			
		"Marvin":
			print("Marvin selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")


func _on_episode_three_pressed() -> void:
	$AnimationPlayer.play("eraseTransition")
	await $AnimationPlayer.animation_finished
	match characterSelects:
		"Jolina":
			print("Jolina selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")
			
		"Marvin":
			print("Marvin selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")


func _on_episode_four_pressed() -> void:
	$AnimationPlayer.play("eraseTransition")
	await $AnimationPlayer.animation_finished
	match characterSelects:
		"Jolina":
			print("Jolina selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")
			
		"Marvin":
			print("Marvin selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")


func _on_episode_five_pressed() -> void:
	$AnimationPlayer.play("eraseTransition")
	await $AnimationPlayer.animation_finished
	match characterSelects:
		"Jolina":
			print("Jolina selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")
			
		"Marvin":
			print("Marvin selected")
			get_tree().change_scene_to_file("res://Episodes-Menu/EpisodeEmpty.tscn")
