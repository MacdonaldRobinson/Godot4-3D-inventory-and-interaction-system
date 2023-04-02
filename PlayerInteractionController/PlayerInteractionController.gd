extends Node3D
class_name PlayerInteractionController

@onready var info_message: Label = $Messages/InfoMessage
@onready var sub_message: Label = $Messages/SubMessage

@export var player_controller: PlayerController

func _ready():
	info_message.text = ""
	sub_message.text = ""
	
func _input(event):
	if player_controller.eyes_cast.is_colliding():
		var collider = player_controller.eyes_cast.get_collider()
		
		if collider is InteractableItem:
			var actions = InputMap.get_actions()
			for action in actions:
				if action == "interact":
					for action_event in InputMap.action_get_events(action):
						if action_event is InputEventKey:
							info_message.text = "Press "+action_event.as_text() +" to interact with: "+ collider.item_name
		else:
			info_message.text = ""
			sub_message.text = ""
	else:
		info_message.text = ""	
		sub_message.text = ""

	if Input.is_action_just_pressed("interact"):
		var collider = player_controller.eyes_cast.get_collider()				
		if collider is CollectableItem:
			collider.interact(player_controller.inventory_controller, 
				func (response: ValidatedResponse): 
					if response.is_error:
						sub_message.text = response.message
						return
						
					var add_response: ValidatedResponse = player_controller.inventory_controller.add_item(collider, 1)
					sub_message.text = add_response.message
			)
			
		elif collider is InteractableItem:
			collider.interact(player_controller.inventory_controller,
				func (response: ValidatedResponse): 
					sub_message.text = response.message
		) 
