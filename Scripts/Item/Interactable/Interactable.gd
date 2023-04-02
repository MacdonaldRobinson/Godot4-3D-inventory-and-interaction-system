extends Item
class_name InteractableItem

func interact(inventory: Inventory, callback: Callable):
	callback.call(ValidatedResponse.create_new_validation_response(false, "Successfully interacted"))	
