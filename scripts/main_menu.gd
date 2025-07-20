extends Node


var flavourTexts = ["no 3D?", "also try spaceinvaders!", "arcady!", "hi", "Hello World!", 
"Warning: May cause existential dread.", "Incoming! (Please don’t hit me.)", 
"Houston, we have a problem!", "Asteroid alert!"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$WatchOut/Label2.text = flavourTexts[randi_range(0, flavourTexts.size()-1)]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_button_2_button_down() -> void:
	get_tree().quit()
