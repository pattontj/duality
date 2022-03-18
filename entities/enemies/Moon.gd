extends Enemy

class_name Moon

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var a = 1

#start_straight_pattern
onready var bullet_spawner = get_owner().get_node("BulletSpawner")

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#bullet_spawner.connect_enemy(self)
	connect("start_straight_pattern", bullet_spawner, "_on_start_straight_pattern")
	connect("start_spinning_pattern", bullet_spawner, "_on_start_spinning_pattern")
	
	emit_signal("start_straight_pattern", 25)
	emit_signal("start_spinning_pattern")
	


func _physics_process(delta):
#	yield(self, "start_straight_pattern")
#	print("test 2")
	
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	pass


