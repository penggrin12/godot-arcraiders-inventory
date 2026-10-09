class_name InventoryContainerSlot extends Control

signal pushed
signal popped

@export var is_discovered := false

var contains: Item = null
var count: int = 0


func is_empty() -> bool:
	return contains == null || count <= 0

func update_tooltip() -> void:
	$Tooltip.text = "" if is_empty() || !is_discovered else "%s%s" % ["x%s " % count if count > 1 else "", contains.name]
	$Tooltip.possibly_show()

func pop(amount: int = 1) -> Item:
	print("pop x%s %s" % [amount, contains.name if contains != null else "null"])
	if is_empty():
		return null
	
	var had = contains
	count -= amount
	if count <= 0:
		contains = null
	update_tooltip()
	popped.emit()
	return had

func push(item: Item, quantity: int = 1) -> bool:
	print("push x%s %s" % [quantity, item.name])
	
	if is_empty():
		contains = item
		count = quantity
		update_tooltip()
		pushed.emit()
		return true
	
	if contains.is_(item):
		count += quantity
		update_tooltip()
		pushed.emit()
		return true
	
	print("fail!")
	return false

func discover() -> void:
	is_discovered = true
	update_tooltip()
	$PanelContainer/DiscoverShine.hide()
	$PanelContainer/Icon.texture = contains.slot_texture if contains != null else null

func _get_drag_data(_at_position: Vector2) -> Variant:
	if is_empty() || !is_discovered:
		return null
	return [self, contains, count]

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if data[0] == self || !is_discovered:
		return false
	if is_empty():
		return true
	if contains.is_(data[1]):
		return true
	return false

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	data[0].pop(data[2])
	push(data[1], data[2])
	data[0].discover()
	discover()
	#get_node("../../..").update_ui()
