@tool
extends Item
class_name InteractableItem

func interact(inventory_controller: InventoryController, callback: Callable):
	callback.call(ValidatedResponse.create_new_validated_response(false, "Successfully interacted"))	

func _get_configuration_warnings():	
	return super._get_configuration_warnings()
