extends Area3D

@export var Timeline: DialogicTimeline
@onready var sprite: Sprite3D = $Sprite
var can_interact: bool = false

func _ready() -> void:
	sprite.visible = false

func body_entered(body: Node3D):
	if body is PlayerController:
		sprite.visible = true
		can_interact = true

func _process(delta: float) -> void:
	if can_interact and Input.is_action_just_pressed("Interact"):
		Dialogic.start(Timeline)
		can_interact = false
		sprite.visible = false
	

func body_exited(body: Node3D):
	if body is PlayerController:
		can_interact = false
		sprite.visible = false
