extends Node

@onready var timer: Timer = $BodySpawnTimer

@export var bodys: Array[PackedScene]
@export var spawnPoints: Array[Node2D]
@export var spawnTime: float
@export var lowestFlySpeed: float = 200
@export var highestFlySpeed: float  = 600

# current bodys in main scene
var bodyList: Array[Node2D]
var screenSize
var score: int


# inbound objects
@onready var label: Label = $UI/Label

# gameover stuff
@onready var gameOverLabel: Label = $UI/GameOverLabel
@onready var button: Button = $UI/Button
@onready var button2: Button = $UI/Button2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screenSize = get_viewport().get_size()
	timer.wait_time = spawnTime;
	
	# make sure game over UI is not visible
	gameOverLabel.visible = false
	button.visible = false
	button2.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Shows current objects/bodyList existing
	label.text = str(bodyList.size()) # "spawntime " + str(spawnTime)
	
	# increase score over time
	score += 100 * delta
	# increase difficulty over time
	spawnTime -= 0.002 * delta
	timer.wait_time = spawnTime;
	if spawnTime <= 0.1:
		spawnTime = 0.1
	
	
	# Check if bodies bodyList are on screen else remove them
	BodyCleanupCheck()

# instantiate body after given time and add to array
func _on_timer_timeout() -> void:
	var body = bodys[randi_range(0, bodys.size()-1)].instantiate()
	body.position = spawnPoints[randi_range(0, spawnPoints.size()-1)].position
	body.flySpeed = randf_range(lowestFlySpeed, highestFlySpeed)
	body.flyDirection = Vector2(randf_range(-0.5, 0.5), 1)
	
	add_child(body) 
	
	bodyList.append(body)


func BodyCleanupCheck():
	for body in bodyList:
		if body.position.y > screenSize.y || body.position.x > screenSize.x:
			body.queue_free()
			bodyList.erase(body)
		if body.position.x < 0 || body.position.y  < 0:
			body.queue_free()
			bodyList.erase(body)


func _on_spaceship_death() -> void:
	# game over
	$Spaceship.queue_free()
	$Explosion.play()
	gameOverLabel.visible = true
	button.visible = true
	button2.visible = true
	gameOverLabel.text = "Game Over! \n Score: " + str(score)

# restart ?
func _on_button_button_down() -> void:
	get_tree().reload_current_scene()

# return to menu ?
func _on_button_2_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
