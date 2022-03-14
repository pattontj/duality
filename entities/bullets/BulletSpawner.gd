extends Node2D

# hold my bullets
var bullets = []

# hold shape type
# Set the collision shape's radius for each bullet in pixels.

onready var game = get_owner()

const moon = preload("res://sprite/moon.png")
const sun =  preload("res://sprite/sun.png")

const bullet_image = preload("res://bullet.png")
const light_bullet = preload("res://sprite/bullet_light.png")
const dark_bullet  = preload("res://sprite/bullet_dark.png")


var genericShape
# Physics2DServer.shape_set_data(genericShape, 8)

static func test(canvas: CanvasItem) -> RID:
	return canvas.get_world_2d().get_space()



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
	bullets_circular_spin(50.0, 50)


func spawn_bullet(type, time = 0):
	
	if type is TimedBullet:
		var bullet = type.new(time)
	
	var bullet = type.new()
	
	Physics2DServer.body_set_space(bullet.body, get_world_2d().get_space())
	
	bullets.push_back(bullet)
	return bullet

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()


#idea: use coroutines here

# Spin the shooting angle in a circle and fire bullets at a given speed
func bullets_circular_spin(spin_speed, bullet_count):
	var spin = 0.0
	var i = 0
	
	for _i in bullet_count:
		
		spin += spin_speed
		i = i+1
		
		#var bullet = TimedBullet.new(50, spin, i)
		var bullet = spawn_bullet(GenericBullet)
		bullet.angle = spin
		





func _physics_process(delta):


	var transform2d = Transform2D()
	
	
	var root_position = get_owner().transform
	var box_shape: RectangleShape2D = get_node("BulletBounds/CollisionShape2D").get_shape()
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
	var offset = -bullet_image.get_size() * 0.5
	for bullet in bullets:
		if game.current_colour == game.light_colour:
			draw_texture(light_bullet, bullet.position + offset)
			
		elif game.current_colour == game.dark_colour:
			draw_texture(dark_bullet, bullet.position + offset)
	
# Perform cleanup operations (required to exit without error messages in the console).
func _exit_tree():
	for bullet in bullets:
		Physics2DServer.free_rid(bullet.body)

	# Physics2DServer.free_rid(shape)
	bullets.clear()
