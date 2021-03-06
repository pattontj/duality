extends Area2D


export var rotate_point = Vector2(0,0)
export var rotate_angle: float
export var rotation_speed = 120.0
export var distance_speed = 2.0
var dist_from_center = 250
var start_angle = 0

onready var _animated_sprite = $AnimatedSprite
var velocity = Vector2()
 
var vert_direction

var hitting = 0

#get_viewport().size.x

signal start_spinning_pattern
signal start_straight_pattern(bullet_amt)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	
	var rot = self.rotation
	var rotation_speed_local = rotation_speed
	var distance_speed_local = distance_speed

	
	#VisualServer.set_default_clear_color(Color(0.4,0.4,0.4,1.0))
#	if Input.is_action_just_pressed("ui_up"):
#		emit_signal("start_spinning_pattern")
#		emit_signal("start_straight_pattern", 25)
	
	
	var game = get_owner()

	if self.position.angle() >= 0.1 and self.dist_from_center >10:
		if game.current_colour != game.dark_colour:
			game.switch_colours()
#		_animated_sprite.play("dark")
		if no_angular_movement():
			vert_direction = 1
		
		#print("normal")
	
	if self.position.angle() < -0.1 and self.dist_from_center >10:
		if game.current_colour != game.light_colour:
			game.switch_colours()
		if no_angular_movement():
			vert_direction = -1
		#print("inverted")

	if Input.is_key_pressed(KEY_SHIFT):
		rotation_speed_local = rotation_speed/2
		distance_speed_local = distance_speed/2
	# TODO: input kinda janky
	if Input.is_action_pressed("Clockwise"):
		self.position = self.position.rotated(1 * rotation_speed_local * delta * (1/dist_from_center))
		
	if Input.is_action_pressed("Counterclockwise"):
		self.position = self.position.rotated(-1 * rotation_speed_local * delta * (1/dist_from_center))

	if Input.is_action_just_pressed("Up"):
		start_angle = self.position.angle()

	if Input.is_action_pressed("Up"):
		#print(start_angle)
		if start_angle >= 0:
			self.position = self.position - self.position.normalized()*distance_speed_local
		else:
			self.position = self.position + self.position.normalized()*distance_speed_local
	if Input.is_action_just_pressed("Down"):
		start_angle = self.position.angle()
					
	if Input.is_action_pressed("Down"):
		
		if start_angle >= 0:
			self.position = self.position +self.position.normalized()*distance_speed_local
		else:
			self.position = self.position- self.position.normalized()*distance_speed_local

	
	
	dist_from_center = sqrt( pow(self.position.x,  2 ) + pow(self.position.y, 2 ) )
	
	
	
	#self.position.y = dist_from_center
	# position = rotate_point + (position-rotate_point).rotated(rotate_angle)
	# global_position = rotate_point
	# global_position += (Vector2( cos(rotate_angle), sin(rotate_angle) ) * dist_from_center) * delta
	
	
	
	
func no_angular_movement() -> bool:
	if (not Input.is_key_pressed(KEY_LEFT)) and (not Input.is_key_pressed(KEY_RIGHT)):
		return true
	else:
		return false
	
	# move_and_slide(velocity)


func _on_Area2D_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	hitting -=1
	
	
	#print(hitting)
	pass # Replace with function body.


func _on_Area2D_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hitting +=1
	var game = get_owner()
	game.update_hp(-1)
	
