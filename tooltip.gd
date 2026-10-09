extends Control

@onready var item_name: Label = %ItemName
@onready var item_price: Label = %ItemPrice
@onready var item_description: RichTextLabel = %ItemDescription

var should_hide = true

func apply_description(item: Item) -> void:
	item_description.clear()
	
	item_description.push_color(Color.hex(0x999999ff))
	item_description.add_text("recycles to:")
	item_description.push_list(0, RichTextLabel.LIST_DOTS, false)
	
	# TODO
	item_description.add_text("3x Seeds")
	
	item_description.pop_all()

func item(item_: Item) -> void:
	set_text_and_show(item_.name)
	apply_description(item_)
	item_price.text = "$%s" % item_.price if item_.price > 0 else ""
	

func set_text_and_show(text: String) -> void:
	if text.is_empty():
		return
	
	item_name.text = text
	item_description.clear()
	
	if is_zero_approx(modulate.a):
		move_to(get_target_position())
	should_hide = false

func hide_if_text_is(text: String) -> void:
	if text.is_empty():
		return
	
	if text == item_name.text:
		should_hide = true

func get_target_position() -> Vector2:
	return get_global_mouse_position() + Vector2(16, 16)

func move_to(pos: Vector2) -> void:
	$PanelContainer.global_position = pos

func _process(delta: float) -> void:
	modulate.a = lerpf(modulate.a, 0 if should_hide else 1, delta * 16)
	if is_zero_approx(modulate.a):
		return
	move_to($PanelContainer.global_position.lerp(get_target_position(), delta * 8))
