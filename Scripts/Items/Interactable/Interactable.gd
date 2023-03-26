extends Item
class_name InteractableItem

signal Interacted

func interact(callback: Callable):
	print("Interacted with "+ item_name)
	Interacted.emit()
