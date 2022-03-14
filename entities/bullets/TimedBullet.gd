extends GenericBullet

class_name TimedBullet

var time = 0


func _init(_speed, _angle, _time).(_speed, _angle):
	time = _time

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
