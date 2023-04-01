extends Item
class_name InteractableItem

signal Interacted(message: String)

func interact(inventory: Inventory, callback: Callable):	
	Interacted.emit("Interacted with "+ item_name)
