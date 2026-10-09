class_name Item extends Resource

@export var name: String = "?"
@export var price: int = 1
@export var slot_texture: Texture2D = Utils.debug_32

func is_(other: Item) -> bool:
	if !is_instance_of(other, Item):
		return false
	return other.name == name

static func create(name_: String, slot_texture_: Texture2D = null) -> Item:
	var item = new()
	item.name = name_
	if slot_texture_:
		item.slot_texture = slot_texture_
	return item
