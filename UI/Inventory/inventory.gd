extends PanelContainer
class_name Inventory

var inventory: Array[InventoryItem] = []
var inventory_capacity: int = 5

@onready var grid: GridContainer = $MarginContainer/GridContainer
@onready var slot_scene: PackedScene = preload("res://UI/Inventory/Slot/slot.tscn")

func _ready():
	clear()

func clear():
	for item in grid.get_children():
		grid.remove_child(item)

func find_item(item: CollectableItem) -> InventoryItem:
	for inventory_item in inventory:
		if inventory_item.item.resource_name == item.item_name:
			return inventory_item
	
	return null
	
func add_item(item: CollectableItem, quantity: int):
	var found_item: InventoryItem = find_item(item)
	
	if found_item == null:
		var new_inventory_item: InventoryItem = InventoryItem.new()
		
		var new_packed_scene = PackedScene.new()
		new_packed_scene.pack(item.duplicate())

		new_inventory_item.item = new_packed_scene
		new_inventory_item.item.resource_name = item.item_name
		new_inventory_item.texture = item.item_texture
		new_inventory_item.slot_index = inventory.size()
		
		new_inventory_item.quantity = 1
		
		inventory.push_back(new_inventory_item)
	else:
		found_item.quantity += quantity
		
	render_inventory()

func render_inventory():
	clear()
	for slot_index in inventory_capacity:
		var slot:Slot = slot_scene.instantiate()
		grid.add_child(slot)
		
	for inventory_entry in inventory:
		var slot: Slot = grid.get_child(inventory_entry.slot_index)
		slot.update_texture(inventory_entry.texture)
		slot.update_quantity(inventory_entry.quantity)
		
