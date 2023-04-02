@tool
extends InteractableItem
class_name CollectableItem

@export var max_amount_collectable: int = 0

func interact(inventory: Inventory, callback: Callable):
	var found_item: InventoryItem = inventory.find_item_by_name(item_name)
	
	if found_item:
		if found_item.quantity >= max_amount_collectable:
			return callback.call(ValidatedResponse.create_new_validated_response(true, "You cannot carry any more items of type: " + item_name))
			
	callback.call(ValidatedResponse.create_new_validated_response(false, "Successfully interacted"))

func _get_configuration_warnings():
	var string_array = super._get_configuration_warnings()
	
	if max_amount_collectable == 0:
		string_array.push_back("You must set the Max Amount Collectable")
		
	return string_array
