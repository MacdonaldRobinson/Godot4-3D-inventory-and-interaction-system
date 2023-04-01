extends InteractableItem
class_name CollectableItem

signal Collected

func interact(inventory: Inventory, callback: Callable):	
	var message: String = "Collect "+item_name
	if callback != null and callback.call(message) != null:
		Collected.connect(callback.call(message))
		Collected.emit()
		Collected.disconnect(callback.call(message))
		
	super(inventory, callback)

	
