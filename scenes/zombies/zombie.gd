extends Node2D

@onready var anim = $AnimationPlayer
var speed = 25
var health_max = 270
var health = 270
var is_active = true
var flash_timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play("Walking")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(flash_timer > 0):
		flash_timer -= delta
	else:
		flash_timer = 0
		modulate = Color(1, 1, 1)
	if is_active:
		
		position.x -= speed * delta
	else:
		if !anim.is_playing():
			queue_free()

func damage(value):
	var old = health
	health -= value
	if(old >= health_max/2 && health_max/2 > health):
		$Polygons/Hip/Torso/Left_Shoulder/Left_Arm.visible = false
		$Polygons/Hip/Torso/Left_Shoulder/Left_Shoulder_Broken.visible = true
	if health <= 0:
		$Polygons/Hip/Torso/Head.visible = false
		anim.play("death")
		is_active = false
	modulate = Color(1.5, 1.5, 1.5)
	flash_timer = 0.16
	
