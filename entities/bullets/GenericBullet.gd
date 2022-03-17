class_name GenericBullet

var genericShape
# Physics2DServer.shape_set_data(genericShape, 8)

static func test(canvas: CanvasItem) -> RID:
	return canvas.get_world_2d().get_space()


var position = Vector2(0,0)
var speed = 1.0
# The body is stored as a RID, which is an "opaque" way to access resources.
# With large amounts of objects (thousands or more), it can be significantly
# faster to use RIDs compared to a high-level approach.
var body = RID()
var angle = 0.0

static func circle():
	return Physics2DServer.circle_shape_create()

func _init( _speed = 50.0, _angle = 0.0):
	speed = _speed
	angle = _angle
	body = Physics2DServer.body_create()
	
	var shape = circle()
	Physics2DServer.body_add_shape(body, shape)
	Physics2DServer.shape_set_data(shape, 8)
	
	Physics2DServer.body_set_collision_layer(body, 0)
	Physics2DServer.body_set_collision_mask(body, 1)


