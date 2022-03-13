extends Node2D

# hold my bullets
var bullets = []

# hold shape type
# Set the collision shape's radius for each bullet in pixels.

var genericShape
# Physics2DServer.shape_set_data(genericShape, 8)

static func test(canvas: CanvasItem) -> RID:
	return canvas.get_world_2d().get_space()


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
	pass



func spawn_bullet(type):
	var bullet = type.new()
	
	Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
	
	bullets.push_back(bullet)
	return bullet

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Spin the shooting angle in a circle and fire bullets at a given speed
func bullets_circular_spin(spin_speed, bullet_count):
	var spin = 0.0
	
	for _i in bullet_count:
		
		spin += spin_speed
		
		var bullet = spawn_bullet(GenericBullet)
		
		bullet.angle = spin



func _physics_process(delta):
	var transform2d = Transform2D()
	
	
	var root_position = get_owner().transform
	# var box_shape: RectangleShape2D = get_node("BulletBounds/CollisionShape2D").get_shape()
	#var bounds_extents_x: Vector2 = shape.get_extents().x
	#var bounds_extents_y: Vector2 = shape.get_extents().y
	#print(root_position)
	#print(box_shape.get_extents())
	
	for bullet in bullets:
		bullet.position.x -= bullet.speed * delta * cos(bullet.angle)
		bullet.position.y -= bullet.speed * delta * sin(bullet.angle)
		
		transform2d.origin = bullet.position
		Physics2DServer.body_set_state(bullet.body, Physics2DServer.BODY_STATE_TRANSFORM, transform2d)
	

		if bullet.position.x < -960 || bullet.position.x >  964:
			bullet.position = Vector2(0, 0)
		
		if bullet.position.y < -539 || bullet.position.y >  540:
			bullet.position = Vector2(0, 0)
	
	#	if not get_node("BulletBounds").overlaps_areas(bullet):
	#		bullet.position = Vector2(0,0)
		



func _draw():
	pass
	
# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	# Physics2DServer.free_rid(shape)
	bullets.clear()
