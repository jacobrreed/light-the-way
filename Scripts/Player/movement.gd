extends CharacterBody2D

@export var move_speed: float = 300.0;


func _physics_process(_delta):
	var input_direction = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))

  # No diagonal movement
	if input_direction.x != 0:
		input_direction.y = 0
	else:
		input_direction.x = 0

	velocity = input_direction.normalized()
	if velocity == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		velocity = input_direction * move_speed
		move_and_slide()
