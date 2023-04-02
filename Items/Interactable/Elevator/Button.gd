extends InteractableItem

@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

enum State{
	Floor1,
	Floor2
}

var current_state: State = State.Floor1

func interact(inventory_controller: InventoryController, callback: Callable):
	if current_state == State.Floor1:
		animation_player.play("Floor2")	
		current_state = State.Floor2
	elif current_state == State.Floor2:
		animation_player.play_backwards("Floor2")	
		current_state = State.Floor1
		
	
