extends Node

export (PackedScene) var MOb
var score


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#new_game()

func game_over():
	$ScoreTimer.stop()
	$MObTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Don't let them touch you!")

func _on_StartTimer_timeout():
	$MObTimer.start()
	$ScoreTimer.start()
	$HUD.update_score(score)

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	#print(score)
	
func _on_MObTimer_timeout():
	#Choose random loc on Path2D MObPath
	$MObPath/MObSpawnLocation.offset = randi()
	
	#Create MOb istance
	var mob = MOb.instance()
	add_child(mob)
	
	#set mob direction perpendicular to path
	var direction = $MObPath/MObSpawnLocation.rotation + PI / 2
	
	#set mob position to rand location
	mob.position = $MObPath/MObSpawnLocation.position
	
	#add randomness to direction
	direction += rand_range(-PI/4, PI/4)
	
	#Set facing
	mob.rotation = direction
	
	#set velocity
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction)


