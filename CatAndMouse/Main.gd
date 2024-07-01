extends Node

export var cat_scene: PackedScene
var score

#func _ready():
	#new_game()

func game_over():
	$ScoreTimer.stop()
	$CatTimer.stop()
	$HUD.show_game_over()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Připraven ke hře")

func _on_CatTimer_timeout():
	var cat = cat_scene.instance()
	var cat_spawn_location = $CatPath/CatSpawnLocation
	cat_spawn_location.offset = randf() 
	var rng = RandomNumberGenerator.new()
	rng.seed = OS.get_unix_time()
	var direction = cat_spawn_location.rotation + PI / 8
	var position = Vector2(rng.randf_range(-100, 100), rng.randf_range(-100, 100))
	print("position", position )
	cat.position = cat_spawn_location.position + position

	
	direction += rng.randf_range(-PI / 8, PI / 8)
	print("direction", direction )
	cat.rotation = direction

	var velocity = Vector2(rng.randf_range(150.0, 250.0), 0.0)
	cat.linear_velocity = velocity.rotated(direction)
	add_child(cat)
		
func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$CatTimer.start()
	$ScoreTimer.start()

