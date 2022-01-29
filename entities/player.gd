extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var rotate_point = Vector2(200,200)
export var rotate_angle: float
export var rotation_speed = 2.0
var dist_from_center = 100

var velocity = Vector2()
 
var direction;


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	
	var rot = get_parent().rotation
	
	if sign(cos(rot)) >= 0 and no_angular_movement():
		direction = 1
		print("normal")
	
	if sign(cos(rot)) == -1 and no_angular_movement():
		direction = -1
		print("inverted")

	
	# TODO: input kinda janky
	if Input.is_key_pressed(KEY_LEFT):
		get_parent().rotate(direction * rotation_speed * delta)
		
	if Input.is_key_pressed(KEY_RIGHT):
		get_parent().rotate(-direction * rotation_speed * delta)
		
	if Input.is_key_pressed(KEY_UP):
		dist_from_center += rotation_speed;
		
	if Input.is_key_pressed(KEY_DOWN):
		dist_from_center -= rotation_speed
	
	

	
	self.position.y = dist_from_center
	# position = rotate_point + (position-rotate_point).rotated(rotate_angle)
	# global_position = rotate_point
	# global_position += (Vector2( cos(rotate_angle), sin(rotate_angle) ) * dist_from_center) * delta
	
	
	
	
func no_angular_movement() -> bool:
	if (not Input.is_key_pressed(KEY_LEFT)) and (not Input.is_key_pressed(KEY_RIGHT)):
		return true
	else:
		return false
	
	# move_and_slide(velocity)
