extends Node3D

@onready var player = $Player
@onready var camera: CameraController = $CameraController

func _process(delta):
	if camera and player:
		camera.set_look_at_point(player.global_position)
