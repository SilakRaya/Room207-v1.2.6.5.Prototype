extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%CameraZoom.play("zoomOut")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_zzdelta: float) -> void:
	pass

func _on_camera_zoom_animation_finished(anim_name: StringName) -> void:
	if anim_name == "zoomOut":
		print("Zoom out finished")
		%CameraZoom.play("Idle")
	
	if anim_name == "moveLeft":
		print("Moving Left Finished")
		%Dialogue.set_process(true)
	
	if anim_name == "moveRight":
		print("Moving Right Finished")
		%Dialogue.set_process(true)
	
	if anim_name == "reset":
		%Dialogue.set_process(true)
	
	if anim_name == "reset2":
		%Dialogue.set_process(true)
		
	if anim_name == "zoom_In_Jolina":
		print("Close up to Jolina Finished")
		%Dialogue.set_process(true)
	
	if anim_name == "move_slightly_left":
		%Dialogue.set_process(true)
