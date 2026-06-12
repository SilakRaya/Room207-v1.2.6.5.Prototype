@tool
extends PointLight2D
class_name PointLightShape2D

@export_multiline var Instructions: String = "- This tool lets you create 2D light textures.
- Move handles in the viewport, put the node below others to register inputs.
- If you use the sliders in the inspector, press 'Bake Light Now'.
- Click 'Save To Disk' to avoid scene bloat and fix size warnings.
- To optimize the lights, use the scale instead of increasing the radius.":
	set(v): pass 

@export_group("Shape Settings")
@export var RESET_SHAPE: bool = false:
	set(v):
		if v:
			_reset_to_defaults()
			RESET_SHAPE = false
		notify_property_list_changed()

@export_range(16, 1024) var radius: int = 128:
	set(v): radius = v; queue_redraw()
@export_range(0, 360) var rotation_deg: float = 0.0:
	set(v): rotation_deg = v; queue_redraw()
@export_range(0.0, 1.0) var falloff: float = 1.0:
	set(v): falloff = v; queue_redraw()
@export_range(0, 360) var arc_degrees: float = 360.0:
	set(v): arc_degrees = v; queue_redraw()
@export_range(0, 360) var inner_arc_degrees: float = 360.0:
	set(v): inner_arc_degrees = v; queue_redraw()

@export_category("Baking & Saving")
@export var BAKE_LIGHT_NOW: bool = false:
	set(v):
		if v:
			do_bake_logic()
		notify_property_list_changed()

@export var SAVE_TO_DISK: bool = false:
	set(v):
		if v:
			_manual_save_to_disk()
		notify_property_list_changed()

@export_file("*.res") var save_path: String = ""

func _init():
	if save_path == "":
		_update_default_path()
	if texture == null:
		texture = PlaceholderTexture2D.new()

func _ready():
	if Engine.is_editor_hint():
		do_bake_logic()
	if not Engine.is_editor_hint():
		set_process(false)
		set_physics_process(false)

func _reset_to_defaults():
	radius = 128
	rotation_deg = 0.0
	falloff = 1.0
	arc_degrees = 360.0
	inner_arc_degrees = 360.0
	queue_redraw()

func _update_default_path():
	var safe_name = name.to_snake_case().replace("@", "")
	if safe_name == "" or safe_name.begins_with("point_light"): 
		safe_name = "light_" + str(get_instance_id())
	save_path = "res://addons/light_shape_2d/baked_lights/" + safe_name + ".res"

func do_bake_logic():
	var safe_radius = max(1, radius)
	var size = safe_radius * 2
	var img = Image.create(size, size, false, Image.FORMAT_RGBA8)
	if img == null: return
	
	var center = Vector2(safe_radius, safe_radius)
	var outer_half_arc = deg_to_rad(arc_degrees) / 2.0
	var inner_half_arc = deg_to_rad(inner_arc_degrees) / 2.0
	var falloff_dist = safe_radius * (1.0 - falloff)
	inner_half_arc = min(inner_half_arc, outer_half_arc - 0.001)

	if arc_degrees >= 360.0:
		for x in range(size):
			for y in range(size):
				var local_pos = Vector2(x, y) - center
				var dist = local_pos.length()
				if dist <= safe_radius:
					var dist_alpha = smoothstep(safe_radius, falloff_dist, dist)
					img.set_pixel(x, y, Color(1, 1, 1, dist_alpha))
	else:
		var light_dir = Vector2.RIGHT.rotated(deg_to_rad(rotation_deg))
		for x in range(size):
			for y in range(size):
				var local_pos = Vector2(x, y) - center
				var dist = local_pos.length()
				if dist <= safe_radius and dist > 0.001:
					var pixel_dir = local_pos / dist
					var angle_diff = abs(light_dir.angle_to(pixel_dir))
					var angle_alpha = smoothstep(outer_half_arc, inner_half_arc, angle_diff)
					var dist_alpha = smoothstep(safe_radius, falloff_dist, dist)
					img.set_pixel(x, y, Color(1, 1, 1, dist_alpha * angle_alpha))

	var tex = ImageTexture.create_from_image(img)
	if tex: self.texture = tex

func _manual_save_to_disk():
	if texture == null or texture is PlaceholderTexture2D: return
	
	if save_path == "" or save_path.contains("new_light"):
		_update_default_path()

	var dir = save_path.get_base_dir()
	if not DirAccess.dir_exists_absolute(dir):
		DirAccess.make_dir_recursive_absolute(dir)
		
	var error = ResourceSaver.save(texture, save_path)
	if error == OK:
		if Engine.is_editor_hint():
			EditorInterface.get_resource_filesystem().scan()
		self.texture = load(save_path)
		print("Saved to: ", save_path)
