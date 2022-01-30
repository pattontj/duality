extends Node2D


var dark_colour = Color(39, 39, 68, 1.0)
var light_colour = Color(251, 245, 239, 1.0)

var current_colour = light_colour



func _ready():
	#VisualServer.set_default_clear_color(light_colour)
	pass



func switch_colours():
	if current_colour == light_colour:
		current_colour = dark_colour
		# switch all the colour stuff in here
	else:
		current_colour = light_colour
		#and in here
	switch_background_colour(current_colour)
	switch_bullets_colour(current_colour)
	switch_player_colour(current_colour)


func switch_background_colour(current):
	VisualServer.set_default_clear_color(current)

	
func switch_bullets_colour(current):
	pass
	
func switch_player_colour(current):
	if current == light_colour:
		get_node("Camera2D/Area2D")._animated_sprite.play("light")
	elif current == dark_colour:
		get_node("Camera2D/Area2D")._animated_sprite.play("dark")



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
