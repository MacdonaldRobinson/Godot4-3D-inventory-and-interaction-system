extends Node3D
class_name PlayerController
 
const SPEED = 5.0
const JUMP_VELOCITY = 6

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_controller:CameraController = $CameraController
@onready  var inventory_controller: InventoryController = $InventoryController

@export var eyes_cast: RayCast3D 
@export var player: Player

func _ready():
	player.velocity = Vector3.ZERO

func _physics_process(delta):
	if not player.is_on_floor():
		player.velocity.y -= gravity * delta

	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		player.velocity.y = JUMP_VELOCITY
	
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (player.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var camera_look_at_point:Vector3 = camera_controller.get_camera_look_at_point()		
	eyes_cast.look_at(camera_look_at_point)	
	
	if direction:		
		player.look_at(Vector3(camera_look_at_point.x, 0, camera_look_at_point.z))
		
		player.rotation.x = 0
		
		player.velocity.x = direction.x * SPEED
		player.velocity.z = direction.z * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		player.velocity.z = move_toward(player.velocity.z, 0, SPEED)		
	
	player.move_and_slide()
