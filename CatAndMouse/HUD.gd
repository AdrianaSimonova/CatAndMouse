extends CanvasLayer


signal start_game
var time_passed = 0.0
var waiting_for_message_timer = false
var waiting_for_one_shot_timer = false

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Konec hry")
	waiting_for_message_timer = true
	time_passed = 0.0 
	set_process(true) 

func _process(delta):
	if waiting_for_message_timer:
		time_passed += delta
		if time_passed >= $MessageTimer.wait_time:
			waiting_for_message_timer = false
			show_zacni_znova_message()

	if waiting_for_one_shot_timer:
		time_passed += delta
		if time_passed >= 2.0:
			waiting_for_one_shot_timer = false
			show_start_button()

func show_zacni_znova_message():
	$MessageLabel.text = "Začni znova!"
	$MessageLabel.show()
	waiting_for_one_shot_timer = true
	time_passed = 0.0 

func show_start_button():
	$StartButton.show()
	set_process(false) 
	
func update_score(score):
	$ScoreLabel.text = str(score)
	
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$MessageLabel.hide()
