extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var cat_types = $AnimatedSprite.frames.get_animation_names()
	if cat_types.size() > 0:
		var catType = cat_types[randi() % cat_types.size()]
		$AnimatedSprite.play(catType)
		print("Animaniton name found", catType )
	else:
		print("No animations found in AnimatedSprite.")




func _on_VisibilityNotifier2D_screen_exited():
	print("Cat exited screen.")
	queue_free()
