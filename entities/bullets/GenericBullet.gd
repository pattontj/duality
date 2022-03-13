extends Node2D

# hold my bullets
var bullets = []

# hold shape type
# Set the collision shape's radius for each bullet in pixels.

var genericShape
# Physics2DServer.shape_set_data(genericShape, 8)
var t = get_world_2d().get_space()

func test():
	if t == null:
		print("null")

class GenericBullet extends Node2D:
#	var position
	var speed = 1.0
	# The body is stored as a RID, which is an "opaque" way to access resources.
	# With large amounts of objects (thousands or more), it can be significantly
	# faster to use RIDs compared to a high-level approach.
	var body = RID()
	var angle = 0.0
	var timer: Timer
	

	static func circle():
		return Physics2DServer.circle_shape_create()
	
	func _init( _speed = 1.0, _angle = 0.0):
		speed = _speed
		angle = _angle

		
		body = Physics2DServer.body_create()
		#Physics2DServer.body_set_space(body, self.get_world_2d().get_space())
		
		var shape = circle()
		Physics2DServer.shape_set_data(shape, 8)
		Physics2DServer.body_add_shape(body, shape)
		
		Physics2DServer.body_set_collision_layer(body, 0)
		Physics2DServer.body_set_collision_mask(body, 1)



class TestBullet extends GenericBullet:
	var p = 2
	

class BigBullet extends GenericBullet:
	var p = 4
	func _init().(5, 5):
		pass

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	

	# init shapes for bullets HERE:
	genericShape = Physics2DServer.circle_shape_create()
	Physics2DServer.shape_set_data(genericShape, 8)
	
	
	var test = spawn_bullet(TestBullet)
	print(typeof(test))
	
	# Physics2DServer.body_add_shape(body, genericShape)
#	# Don't make bullets check collision with other bullets to improve performance.
#	# Their collision mask is still configured to the default value, which allows
#	# bullets to detect collisions with the player.
#	Physics2DServer.body_set_collision_layer(body, 0)
#	Physics2DServer.body_set_collision_mask(body, 1)

	


func spawn_bullet(type):
	var bullet = type.new()
	
	if type is TestBullet:
		print("works")
	bullets.push_back(bullet)
	return bullet

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Spin the shooting angle in a circle and fire bullets at a given speed
func bullets_circular_spin(spin_speed, bullet_count):
	for _i in bullet_count:
		
		var bullet = GenericBullet.new(self)
		
		bullet.angle += spin_speed
		bullets.push_back(bullet)
		

"""
bullet.speed = rand_range(SPEED_MIN, SPEED_MAX)

		bullet.body = Physics2DServer.body_create()
		bullet.angle = _i*((2*PI)/BULLET_COUNT)

		Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
		Physics2DServer.body_add_shape(bullet.body, shape)
		# Don't make bullets check collision with other bullets to improve performance.
		# Their collision mask is still configured to the default value, which allows
		# bullets to detect collisions with the player.
		Physics2DServer.body_set_collision_layer(bullet.body, 0)
		Physics2DServer.body_set_collision_mask(bullet.body, 1)
		
		#camera = get_child()
		
		
		# bullet.position = camera.get_camera_screen_center()
		# Place bullets randomly on the viewport and move bullets outside the
		# play area so that they fade in nicely.
		# bullet.position = Vector2(0 ,0
			# get_viewport_rect().size.x/2,
			# get_viewport_rect().size.y/2
		
		# )
		#The bullet will be spawned at the center
		bullet.position = Vector2(0,0)
	

		var transform2d = Transform2D()
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)
"""
