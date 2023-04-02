extends CharacterBody3D
class_name PlayerController

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_controller:CameraController = $"../CameraController"
@onready var eyes_cast: RayCast3D = $EyesCast
@export  var inventory_controller: InventoryController

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var camera_look_at_point:Vector3 = camera_controller.get_camera_look_at_point()		
	eyes_cast.look_at(camera_look_at_point)	

	if direction:		
		self.look_at(Vector3(camera_look_at_point.x, 0, camera_look_at_point.z))
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
