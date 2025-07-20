extends Area2D

var flySpeed
var flyDirection: Vector2

@export var maxRotationSpeed: float = 100
@export var minRotationSpeed: float = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# process fly direction
	position += flyDirection * flySpeed * delta
	rotation_degrees += randf_range(minRotationSpeed, maxRotationSpeed) * delta
