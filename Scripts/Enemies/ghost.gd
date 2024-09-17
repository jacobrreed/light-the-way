extends CharacterBody2D
class_name Ghost

@onready var animation_tree: AnimationTree = $AnimationTree
@export var chase_target: Player
@export var move_speed: float = 100.0;
@onready var walk: Sprite2D = $Walk
@onready var idle: Sprite2D = $Idle

func _physics_process(delta):
	velocity = Vector2.ZERO
	animation_tree.get("parameters/playback").travel("Idle")
	walk.hide()
	idle.show()

	if (chase_target):
		velocity = position.direction_to(chase_target.position) * move_speed
		animation_tree.get("parameters/playback").travel("Walk")
		idle.hide()
		walk.show()
		
	move_and_slide()
