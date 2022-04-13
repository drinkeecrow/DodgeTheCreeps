extends Area2D

signal hit

export var speed = 400
var screen_size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size # Replace with function body.
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var vel = Vector2()
	if Input.is_action_pressed("ui_right"):
		vel.x += 1
	if Input.is_action_pressed("ui_left"):
		vel.x -= 1
	if Input.is_action_pressed("ui_down"):
		vel.y += 1
	if Input.is_action_pressed("ui_up"):
		vel.y -= 1
	if vel.length() > 0:
		vel = vel.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += vel * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if vel.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = vel.x < 0
	elif vel.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = vel.y > 0


func _on_Player_body_entered(_body):
	hide() #player disappears after being hit
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
