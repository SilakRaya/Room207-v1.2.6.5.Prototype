extends Node3D


func _on_area_3d_body_entered(body):
	if body.is_in_group("jolina"):
		print("Jolina enters a bush")

func _on_area_3d_body_exited(body):
	if body.is_in_group("jolina"):
		print("Jolina enters a bush")
