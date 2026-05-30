extends Control

# Encapsulation
# Enter dialogue here! through properties
@export var _Jolina_Lines:Array[String] = []
@export var repeat:bool = false
@export var _typing_speed:float = 0.1

var _full_text:String = ""
var index:int = 0
var dialogue:int = 0
var typing:bool = false


@onready var _typing_timer: Timer = $TypingTimer

func _ready() -> void:
	displayText(_Jolina_Lines[dialogue])

func _process(_delta):
	if Input.is_action_just_pressed("mobile_dialogue"):
		print("Detected")
		switchText()

# Abstraction
func displayText(new_text: String) -> void:
	typing = true #this check if it is still typing
	
	_full_text = new_text
	
	# Reset typing
	index = 0
	%Text.visible_characters = 0
	
	_typing_timer.wait_time = _typing_speed
	_typing_timer.start()
	
	%Text.text = _full_text

func switchText() -> void:
	if typing:
		return
	
	if dialogue < _Jolina_Lines.size() - 1:
		dialogue += 1
	else:
		if repeat:
			dialogue = 0
		else:
			return

	displayText(_Jolina_Lines[dialogue])

# Timer signal
func _on_typing_timer_timeout() -> void:
	index += 1
	%Text.visible_characters = index
	
	if index >= _full_text.length():
		_typing_timer.stop()
		typing = false
