extends Node2D

class_name BulletSpawner


onready var game = get_owner()

const moon = preload("res://sprite/moon.png")
const sun =  preload("res://sprite/sun.png")

const bullet_image = preload("res://bullet.png")
const light_bullet = preload("res://sprite/bullet_light.png")
const dark_bullet  = preload("res://sprite/bullet_dark.png")


var genericShape
# Physics2DServer.shape_set_data(genericShape, 8)


# holds bullets for every pattern
# TODO: consider adding a cap to bullets for performance
onready var bullets = []

# Maximum amount of patterns allowed on the screen at one time
const MAX_PATTERNS = 2
onready var active_patterns = []


# For architecture testing purposes, consider deleting if not needed anymore
class TestPattern:
	var space: RID
	var bullet_count: int
	
	var frame_counter = 0
	var shoot_speed_modulator = 4
	
	func _init(_space: RID, _bullet_num: int = 0):
		space        = _space
		bullet_count = _bullet_num
		
		
	func setup(_count: int):
		bullet_count = _count
		
	func shoot(bullets: Array):

		if frame_counter > shoot_speed_modulator && bullet_count > 0:
			var b = GenericBullet.new(150, (3 * PI) /2)
			Physics2DServer.body_set_space(b.body, space)
			bullets.push_back(b)
			frame_counter = 0
			bullet_count -= 1
		
		frame_counter += 1

class StraightPattern extends Node2D:
	var space: RID
	var bullet_count: int
	
	var frame_counter = 0
	var shoot_speed_modulator = 4
	
	signal end_straight_pattern
	
	func _init(_space: RID, _bullet_num: int):
		space        = _space
		bullet_count = _bullet_num
		
		
	func shoot(bullets: Array):
		if bullet_count == 0:
			print("free straight pattern")
			queue_free()
			return
		
		if frame_counter > shoot_speed_modulator:
			var b = GenericBullet.new(150, (3 * PI) /2)
			Physics2DServer.body_set_space(b.body, space)
			bullets.push_back(b)
			frame_counter = 0
			bullet_count -= 1
		
		frame_counter += 1

class SpinPattern:
	var spin = 0
	var spin_speed = 0.2
	
	var frame_counter = 0
	
	var shoot_speed_modulator = 4
	
	var space: RID
	
	func _init(_space: RID):
		space = _space

	
	func shoot(bullets: Array):
		if frame_counter > shoot_speed_modulator:
			spin += spin_speed
			var b = GenericBullet.new(50, spin)
			Physics2DServer.body_set_space(b.body, space)
			bullets.push_back(b)
			frame_counter = 0
			
		frame_counter += 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


func _physics_process(delta):

	var transform2d = Transform2D()
	
	var root_position = get_owner().transform
	#var box_shape: CircleShape2D = get_node("BulletBounds/CollisionShape2D").get_shape()
	#var bounds_extents_x: Vector2 = shape.get_extents().x
	#var bounds_extents_y: Vector2 = shape.get_extents().y
	#print(root_position)
	#print(box_shape.get_extents())
	
	#spinning_bullets.shoot(bullets)
	
#	if is_instance_valid(spinning_bullets):
#		spinning_bullets.shoot(bullets)
	
#	if is_instance_valid(straight_bullets):
#		straight_bullets.shoot(bullets)
		
	
	# call shoot on all active patterns
	for pattern in active_patterns:
		if is_instance_valid(pattern):
			pattern.shoot(bullets)
		
		#if the pattern object has deleted itself, remove it from active patterns
		elif !is_instance_valid(pattern):
			active_patterns.erase(pattern)

		
	# Runs physics on all bullets
	for bullet in bullets:
		
		bullet.position.x -= bullet.speed * delta * cos(bullet.angle)
		bullet.position.y -= bullet.speed * delta * sin(bullet.angle)
			
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)
	

		if bullet.position.x < -960 || bullet.position.x >  964:
			#bullet.position = Vector2(0, 0)
			Physics2DServer.free_rid(bullet.body)
			bullets.erase(bullet)
			
		
		if bullet.position.y < -539 || bullet.position.y >  540:
			#bullet.position = Vector2(0, 0)
			Physics2DServer.free_rid(bullet.body)
			bullets.erase(bullet)
			
	#	if not get_node("BulletBounds").overlaps_areas(bullet):
	#		bullet.position = Vector2(0,0)


func _draw():
	var offset = -bullet_image.get_size() * 0.5
	for bullet in bullets:
		if game.current_colour == game.light_colour:
			draw_texture(light_bullet, bullet.position + offset)
			
		elif game.current_colour == game.dark_colour:
			draw_texture(dark_bullet, bullet.position + offset)


## BULLET SPAWNING FUNCTIONS

func start_spinning_pattern() -> SpinPattern:
	if active_patterns.size() < MAX_PATTERNS:
		var ret = SpinPattern.new(get_world_2d().get_space())
		active_patterns.push_back(ret)
		return ret
	else:
		return null


func start_straight_pattern(bullet_amt: int) -> StraightPattern:
	if active_patterns.size() < MAX_PATTERNS:
		var ret = StraightPattern.new(get_world_2d().get_space(), bullet_amt)
		active_patterns.push_back(ret)
		return ret
	else:
		return null


# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	# Physics2DServer.free_rid(shape)
	bullets.clear()
