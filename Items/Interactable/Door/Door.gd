extends InteractableItem

@onready var door_hinge: Node3D = $".."
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"

enum State {
	Open,
	Close
}

var current_state: State = State.Close

func interact(inventory_controller: InventoryController, callback: Callable):
	var found_item: InventoryItem = inventory_controller.find_item_by_name("Key")
	
	if found_item:
		if current_state == State.Close:
			animation_player.play("Open")
			current_state = State.Open		
		else:
			animation_player.play_backwards("Open")
			current_state = State.Close
			
		callback.call(ValidatedResponse.create_new_validated_response(false, "Successfully interacted with Door"))
	else:
		callback.call(ValidatedResponse.create_new_validated_response(false, "You do not have a key to open this door"))
	
