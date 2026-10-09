class_name InventoryContainer extends PanelContainer

@export var dimensions := Vector2i.ONE
@export var all_discovered := false

enum Type {REGULAR = 0, GARBAGE, RECYCLER}
@export var type := Type.REGULAR

var slots: Array[InventoryContainerSlot] = []
@export var default_items: Array[Item] = []

const slot_scene: PackedScene = preload("res://inventory_container_slot.tscn")


func get_total_slots() -> int:
	return dimensions.x * dimensions.y

func add_item(item: Item, quantity: int = 1) -> bool:
	for slot in slots:
		if !slot.push(item, quantity):
			continue
		return true
	return false

func update_ui() -> void:
	$MarginContainer/GridContainer.columns = dimensions.x
	for slot in slots:
		if slot.is_empty() || all_discovered:
			slot.discover()
		$MarginContainer/GridContainer.add_child(slot)

func _ready() -> void:
	for y in dimensions.y:
		for x in dimensions.x:
			var slot := slot_scene.instantiate()
			slot.name = "%s-%s" % [x, y]
			if type in [Type.GARBAGE, Type.RECYCLER]:
				slot.pushed.connect(func(): slot.pop(slot.count))
			slots.append(slot)
	for item in default_items:
		add_item(item)
	update_ui()

func _on_discovery_timer_timeout() -> void:
	for slot in slots:
		if slot.is_discovered:
			continue
		slot.discover()
		return
	$DiscoveryTimer.stop()
