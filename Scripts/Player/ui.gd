extends Control
@onready var fuel_bar: ProgressBar = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/FuelBar
@onready var health_bar: ProgressBar = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/HealthBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_player_fuel_changed(currentFuel: float) -> void:
	fuel_bar.value = currentFuel


func _on_player_health_changed(currentHealth: float) -> void:
	health_bar.value = currentHealth
