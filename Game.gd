extends Node2D


var dark_colour = Color("#272744")
var light_colour = Color("#FBF5EF")

var current_colour = light_colour
var hp = 100
onready var background = $ColorRect
onready var fade_out  =  $FadeOut
onready var hp_label = $Camera2D/RichTextLabel

onready var dialog = Dialogic.start("testConvo")

func _ready():
	background.color = current_colour
	fade_out.color = current_colour
	fade_out.visible = false
	
	hp_label.push_color(dark_colour)
	hp_label.append_bbcode(str("hp: ", hp))
	hp_label.pop()
#	hp_label.set_bbcode("[color=#"+dark_colour.to_html(false)+str("HP: ", hp)+ "[/color]")
	
	add_child(dialog)


func switch_colours():
	if current_colour == light_colour:
		current_colour = dark_colour
		switch_bullets_colour(current_colour)
		switch_player_colour(current_colour)
		switch_background_colour(current_colour)
		#switch_label_colour(current_colour)
	elif current_colour == dark_colour:
		current_colour = light_colour
		switch_bullets_colour(current_colour)
		switch_player_colour(current_colour)
		switch_background_colour(current_colour)
		#switch_label_colour(current_colour)

	else:
		null.test()

func update_hp(change):
	hp = hp + change

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


func switch_label_colour(current):
	if current == light_colour:
		hp_label.push_color(dark_colour)
		hp_label.pop()
		
	elif current == dark_colour:

		hp_label.push_color(light_colour)
		hp_label.pop()
		#hp_label.set_bbcode("[color=#"+light_colour.to_html(false)+str("HP: ", hp) + "[/color]")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
