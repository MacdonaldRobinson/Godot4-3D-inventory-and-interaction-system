extends InteractableItem
class_name CollectableItem

signal Collected

func interact(callback: Callable):
	print("Collect "+item_name)	
	if callback != null and callback.call() != null:
		Collected.connect(callback.call())
		Collected.emit()
		Collected.disconnect(callback.call())
	
