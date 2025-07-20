extends Area2D

@export var health: int = 3
@export var speed: float = 700

@onready var healthLabel: Label = $"../UI/Health"

var screenSize

signal death

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get the size of the screen
	screenSize = get_viewport_rect().size
	
	# Position the player in the middle
	position.x = screenSize.x/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Get the input
	var direction: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		
		
	# process movement
	position.x += direction.x * speed * delta
	position = position.clamp(Vector2.ZERO, screenSize)
	
	# display Health
	healthLabel.text = str(health)
	
	if (health <= 0):
		death.emit()
	
	

# Decrease health on collision
func _on_area_entered(area: Area2D) -> void:
	health -= 1
	# play sound
	$DamageSound.play()
