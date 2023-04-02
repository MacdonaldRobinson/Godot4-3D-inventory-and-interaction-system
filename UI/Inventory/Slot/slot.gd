extends PanelContainer
class_name Slot

@onready var quantity: Label = $SlotContainer/Quantity
@onready var texture_rect: TextureRect = $SlotContainer/Texture

signal SlotOnGuiInput(event, slot:Slot)

var inventory_item: InventoryItem
var slot_index: int

func _ready():
	texture_rect.texture = null
	quantity.hide()
	pass

func set_inventory_item(inventory_item: InventoryItem):
	self.inventory_item = inventory_item
	
	texture_rect.texture = inventory_item.texture
	quantity.text = "x"+str(inventory_item.quantity)

	if inventory_item.quantity == 0:
		quantity.hide()
	else:
		quantity.show()

func _on_gui_input(event):
	SlotOnGuiInput.emit(event, self)
