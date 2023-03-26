extends PanelContainer
class_name Slot

@onready var quantity: Label = $SlotContainer/Quantity
@onready var texture_rect: TextureRect = $SlotContainer/Texture

var current_quantity: int = 0
var current_texture: Texture

func _ready():
	texture_rect.texture = null
	quantity.hide()
	
func update_texture(new_texture: Texture):
	current_texture = new_texture
	texture_rect.texture = new_texture
	
func update_quantity(new_quantity: int):
	current_quantity = new_quantity
	quantity.text = "x"+str(current_quantity)
	
	if current_quantity == 0:
		quantity.hide()
	else:
		quantity.show()
	
	
