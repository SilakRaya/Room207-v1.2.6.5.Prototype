## This tool lets you create 2D light textures inside the editor
@tool
extends EditorPlugin

var dragging_radius = false
var dragging_rotation = false
var dragging_arc = false
var dragging_inner_arc = false
var selected_light: PointLightShape2D = null

func _edit(object):
	if object is PointLightShape2D:
		selected_light = object
	else:
		selected_light = null
	update_overlays()

func _handles(object):
	return object is PointLightShape2D

func _forward_canvas_gui_input(event):
	if not selected_light:
		return false

	var screen_transform = selected_light.get_viewport_transform() * selected_light.get_global_transform_with_canvas()
	var center = screen_transform.origin
	var scale = screen_transform.get_scale().x
	var radius = selected_light.radius * scale
	
	var rot_rad = deg_to_rad(selected_light.rotation_deg)
	var arc_rad = deg_to_rad(selected_light.arc_degrees)

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			# Detection
			var rot_handle_pos = center + Vector2.RIGHT.rotated(rot_rad) * (radius + 20)
			if event.position.distance_to(rot_handle_pos) < 15:
				dragging_rotation = true
				return true
			
			var arc_handle_pos = center + Vector2.RIGHT.rotated(rot_rad + arc_rad/2) * radius
			if event.position.distance_to(arc_handle_pos) < 12:
				dragging_arc = true
				return true
				
			var inner_rad = deg_to_rad(selected_light.inner_arc_degrees)
			var inner_handle_pos = center + Vector2.RIGHT.rotated(rot_rad + inner_rad/2) * radius
			if event.position.distance_to(inner_handle_pos) < 12:
				dragging_inner_arc = true
				return true

			var mouse_dist = event.position.distance_to(center)
			if abs(mouse_dist - radius) < 10:
				dragging_radius = true
				return true
		else:
			# Mouse release
			if dragging_radius or dragging_rotation or dragging_arc or dragging_inner_arc:
				selected_light.do_bake_logic()
				dragging_radius = false
				dragging_rotation = false
				dragging_arc = false
				dragging_inner_arc = false
				update_overlays()
				return true

	if event is InputEventMouseMotion:
		if dragging_radius or dragging_rotation or dragging_arc or dragging_inner_arc:
			var mouse_angle = center.angle_to_point(event.position)
			var relative_angle = abs(wrapf(mouse_angle - rot_rad, -PI, PI)) * 2.0
			
			if dragging_radius:
				selected_light.radius = int(center.distance_to(event.position) / scale)
			elif dragging_rotation:
				selected_light.rotation_deg = rad_to_deg(mouse_angle)
			elif dragging_arc:
				selected_light.arc_degrees = clamp(rad_to_deg(relative_angle), 1, 360)
			elif dragging_inner_arc:
				selected_light.inner_arc_degrees = clamp(rad_to_deg(relative_angle), 0, selected_light.arc_degrees)
			
			update_overlays()
			return true # This prevents the editor from highlighting other nodes while dragging

	return false

func _forward_canvas_draw_over_viewport(overlay: Control):
	if not selected_light:
		return

	var vp_transform = selected_light.get_viewport_transform()
	var canvas_transform = selected_light.get_global_transform_with_canvas()
	var screen_transform = vp_transform * canvas_transform
	
	var center = screen_transform.origin
	var scale = screen_transform.get_scale().x
	var radius = selected_light.radius * scale
	
	var rot_rad = deg_to_rad(selected_light.rotation_deg)
	var arc_rad = deg_to_rad(selected_light.arc_degrees)
	var inner_rad = deg_to_rad(selected_light.inner_arc_degrees)
	
	# Outer arc
	overlay.draw_arc(center, radius, rot_rad - arc_rad/2, rot_rad + arc_rad/2, 64, Color.GOLD, 2.0)
	
	var dir_left = Vector2.RIGHT.rotated(rot_rad - arc_rad/2)
	var dir_right = Vector2.RIGHT.rotated(rot_rad + arc_rad/2)
	overlay.draw_line(center, center + dir_left * radius, Color.GOLD, 2.0)
	overlay.draw_line(center, center + dir_right * radius, Color.GOLD, 2.0)
	
	# Inner radius line for the inner arc
	var dir_inner = Vector2.RIGHT.rotated(rot_rad + inner_rad/2)
	var pos_inner = center + dir_inner * radius
	overlay.draw_line(center, pos_inner, Color(1.0, 0.0, 1.0, 0.4), 1.5)
	
	# Rotation handle
	var rot_handle_pos = center + Vector2.RIGHT.rotated(rot_rad) * (radius + 20)
	overlay.draw_line(center, rot_handle_pos, Color.CYAN, 1.5)
	overlay.draw_circle(rot_handle_pos, 5, Color.CYAN)

	# Pancake handles
	var pos_arc = center + dir_right * radius
	_draw_diamond(overlay, pos_arc, 6, Color.GOLD) # Outer Arc handle
	_draw_diamond(overlay, pos_inner, 5, Color(1.0, 0.0, 1.0, 1.0)) # Inner Arc handle

func _draw_diamond(overlay: Control, pos: Vector2, size: float, color: Color):
	var pts = PackedVector2Array([
		pos + Vector2(0, -size), # Top
		pos + Vector2(size, 0),  # Right
		pos + Vector2(0, size),  # Bottom
		pos + Vector2(-size, 0)  # Left
	])
	overlay.draw_colored_polygon(pts, color)

func _notification(what):
	if what == NOTIFICATION_PROCESS:
		update_overlays()

func _enter_tree():
	set_process(true)

func _exit_tree():
	set_process(false)
