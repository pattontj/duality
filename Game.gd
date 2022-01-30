extends Node2D


var dark_colour = Color("#272744")
var light_colour = Color("#FBF5EF")

var current_colour = light_colour

onready var background = $ColorRect
onready var fade_out  =  $FadeOut

func _ready():
	background.color = current_colour
	fade_out.color = current_colour
	fade_out.visible = false

func switch_colours():
	if current_colour == light_colour:
		current_colour = dark_colour
		switch_bullets_colour(current_colour)
		switch_player_colour(current_colour)
		switch_background_colour(current_colour)
	elif current_colour == dark_colour:
		current_colour = light_colour
		switch_bullets_colour(current_colour)
		switch_player_colour(current_colour)
		switch_background_colour(current_colour)

	else:
		null.test()



func switch_background_colour(current):
#	background.color = current
	if current == light_colour:
		background.color = dark_colour
		fade_out.color = dark_colour
	else:
		background.color = light_colour
		fade_out.color = light_colour

	
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
