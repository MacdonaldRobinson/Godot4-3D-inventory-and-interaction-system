extends InteractableItem
class_name CollectableItem

func interact(inventory: Inventory, callback: Callable):	
	if callback:	
		callback.call(ValidatedResponse.create_new_validated_response(false, "Successfully interacted"))

	
