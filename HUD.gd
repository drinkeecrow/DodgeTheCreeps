extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	#wait until message timer has counted down and then display
	yield($MessageTimer, "timeout")
	
	$Message.text = "You Didn't Dodge the Creeps!"
	$Message.show()
	
	#Make a one-shot timer and wait for it to finish
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

	

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()

func update_score(score):
	$ScoreLabel.text = str(score)
