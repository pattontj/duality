extends Node2D

class_name Enemy

export var hp: int

signal start_straight_pattern(bullet_amt)
signal start_spinning_pattern
signal end_straight_pattern

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func test():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
