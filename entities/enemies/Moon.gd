extends Enemy

class_name Moon

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var active = []

var counter = 0
var count_to = 120


onready var bullet_spawner = get_owner().get_node("BulletSpawner")

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	
	if counter >= 120:
		var straight = bullet_spawner.start_straight_pattern(10)
		active.push_back(straight)
		counter = 0
	
	counter += 1

	for pattern in active:
		if !is_instance_valid(pattern):
			active.erase(pattern)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_shooting_stopped():
	pass

