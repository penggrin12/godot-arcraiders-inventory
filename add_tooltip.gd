extends Node

@onready var _parent := get_parent() as Control
@export var text := ""

func _ready() -> void:
	_parent.mouse_entered.connect(func(): Tooltip.set_text_and_show(text))
	_parent.mouse_exited.connect(func(): Tooltip.hide_if_text_is(text))

func possibly_show() -> void:
	if _parent == null:
		return
	if _parent.get_global_rect().has_point(_parent.get_global_mouse_position()):
		Tooltip.set_text_and_show(text)
