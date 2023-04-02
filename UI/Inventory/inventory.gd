extends PanelContainer
class_name Inventory

var inventory: Array[InventoryItem] = []
var inventory_capacity: int = 6

@onready var grid: GridContainer = $MarginContainer/GridContainer
@onready var slot_scene: PackedScene = preload("res://UI/Inventory/Slot/slot.tscn")

var move_slot: Slot = null

func _ready():
	clear()
	render_inventory_slots()
	pass

func clear():
	for item in grid.get_children():
		grid.remove_child(item)

func find_item(item: CollectableItem) -> InventoryItem:
	return find_item_by_name(item.item_name)
	
func find_item_by_name(item_name: String) -> InventoryItem:
	for inventory_item in inventory:
		if inventory_item.item.resource_name == item_name:
			return inventory_item
	
	return null	
	
func add_item(item: CollectableItem, quantity: int) -> ValidatedResponse:
	var found_item: InventoryItem = find_item(item)
	
	if found_item == null:
		if is_inventory_full():
			return ValidatedResponse.create_new_validated_response(true, "Inventory is full")
			
		var new_inventory_item: InventoryItem = InventoryItem.new()
		
		var new_packed_scene = PackedScene.new()
		new_packed_scene.pack(item.duplicate())

		new_inventory_item.item = new_packed_scene
		new_inventory_item.item.resource_name = item.item_name
		new_inventory_item.texture = item.item_texture
		new_inventory_item.slot_index = inventory.size()
		new_inventory_item.quantity = 1
		
		inventory.push_back(new_inventory_item)
		render_inventory_items_into_available_slots()	
		return ValidatedResponse.create_new_validated_response(false, "Successfully collected new item: "+ item.item_name)
	else:
		found_item.quantity += quantity
		render_inventory_items_into_available_slots()	
		return ValidatedResponse.create_new_validated_response(false, "Successfully increased the quantity of "+ item.item_name)
		

func is_inventory_full() -> bool:
	if inventory.size() == inventory_capacity:
		return true
				
	return false

func render_inventory_slots():
	clear()
	for slot_index in inventory_capacity:
		var slot:Slot = slot_scene.instantiate()
		slot.SlotOnGuiInput.connect(SlotOnGuiInput)
		slot.name = str(slot_index)
		slot.slot_index = slot_index
		grid.add_child(slot)

func render_inventory_items_into_available_slots():
	for inventory_entry in inventory:
		var slot: Slot = grid.get_child(inventory_entry.slot_index)
		slot.set_inventory_item(inventory_entry)
		
func _input(event):
	if event is InputEventMouseMotion:
		if move_slot:
			move_slot.top_level = true
			move_slot.global_position = get_viewport().get_mouse_position() + Vector2(10, 10)
			
func SlotOnGuiInput(event, slot: Slot):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == 1:
			if !move_slot:	
				move_slot = slot
			else:
				var old_index = move_slot.slot_index
				var new_index = slot.slot_index
				
				print(old_index, " -> ",new_index)
				
				if move_slot.inventory_item:
					move_slot.inventory_item.slot_index = new_index
				
				if slot.inventory_item:
					slot.inventory_item.slot_index = old_index
				
				render_inventory_slots()
				render_inventory_items_into_available_slots()
				
				move_slot = null
		elif event.pressed and event.button_index == 2:
			if move_slot:
				move_slot = null
				render_inventory_slots()
				render_inventory_items_into_available_slots()
				
			
			
				
	
