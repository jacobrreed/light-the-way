extends CharacterBody2D
class_name Player

@export var move_speed: float = 300.0;
var currentHealth: float = 100;
@export var maxHealth: float = 100;
var currentFuel: float = 100;
@export var maxFuel: float = 100;
@export var fuelConsumptionRate: float = 0.15;
@export var healthWithNoFuelDecayRate: float = 4;
signal fuelChanged(currentFuel: float);
signal healthChanged(currentHealth: float);
@export var healthReductionOnHit: float = 10;

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
		set_fuel(fuelConsumptionRate)
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position", velocity)
		$AnimationTree.set("parameters/Walk/blend_position", velocity)
		velocity = input_direction * move_speed
		ghost_collisions()
		move_and_slide()
		

func ghost_collisions() -> void:
	# Get collisions
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		var enemy: Ghost = collider as Ghost
		if enemy:
			set_health(healthReductionOnHit)
			enemy.queue_free()

func _process(delta: float) -> void:
	if (is_fuel_depleted()):
		set_health(healthWithNoFuelDecayRate * delta)

func is_fuel_depleted() -> bool:
	return floor(currentFuel) <= 0
	
func set_fuel(fuel: float) -> void:
	var newFuel: float = currentFuel - fuel
	if (floor(newFuel) > 0):
		currentFuel = newFuel
		fuelChanged.emit(currentFuel)
	else:
		currentFuel = 0
		fuelChanged.emit(currentFuel)
	
func set_health(health: float) -> void:
	var newHealth: float = currentHealth - health
	if (floor(newHealth) > 0):
		currentHealth = newHealth
		healthChanged.emit(currentHealth)
	else:
		currentHealth = 0
		healthChanged.emit(currentHealth)
		print("DEAD")
