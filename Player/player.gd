extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_controller:CameraController = $"../CameraController"
@onready var eyes_cast: RayCast3D = $EyesCast
@onready var info_message: Label = $InfoMessage
@onready var inventory: Inventory = $Inventory

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var camera_look_at_point:Vector3 = camera_controller.get_camera_look_at_point()		
	eyes_cast.look_at(camera_look_at_point)
	
	
	if eyes_cast.is_colliding():
		var collider = eyes_cast.get_collider()
				
		if collider is InteractableItem:
			var actions = InputMap.get_actions()
			for action in actions:
				if action == "interact":
					for action_event in InputMap.action_get_events(action):
						if action_event is InputEventKey:
							info_message.text = "Press "+action_event.as_text()
		else:
			info_message.text = ""
							
	else:
		info_message.text = ""	
		
	if Input.is_action_just_pressed("interact"):
		var collider = eyes_cast.get_collider()				
		if collider is CollectableItem:
			collider.interact(inventory,
			func (message): 
				inventory.add_item(collider, 1)
				info_message.text = message				
			)
		elif collider is InteractableItem:
			collider.interact(inventory, 
			func (message: String): 
				info_message.text = message	
			)
	
	
	if direction:		
		self.look_at(Vector3(camera_look_at_point.x, 0, camera_look_at_point.z))
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
