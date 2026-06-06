extends Area2D

var player : CharacterBody2D = null
var offset_LEFT : int = -8
var offset_RIGHT : int = 8

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body


func _on_body_exited(body: Node2D) -> void:
	if body == player:
		player = null

func _process(_delta: float) -> void:
	if player:
		print(player.global_position)
