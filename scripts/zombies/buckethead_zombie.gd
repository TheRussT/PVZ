extends "res://scripts/zombies/zombie.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 960; #730 500
	anim.play("Walking")
	row = 1

func damage(value):
	var old = health
	health -= value
	if (health > health_max):
		if(health < 360):
			$Polygons/Hip/Torso/Head/Headwear/Bucket_Damaged.visible = false
			$Polygons/Hip/Torso/Head/Headwear/Bucket_Broken.visible = true
		elif(health < 450):
			$Polygons/Hip/Torso/Head/Headwear/Bucket.visible = false
			$Polygons/Hip/Torso/Head/Headwear/Bucket_Damaged.visible = true
	else:
		$Polygons/Hip/Torso/Head/Headwear/Cone_Damaged.visible = false
		$Polygons/Hip/Torso/Head/Headwear/Cone.visible = false
		$Polygons/Hip/Torso/Head/Headwear/Cone_Broken.visible = false
	if(old >= health_max/2 && health_max/2 > health):
		$Polygons/Hip/Torso/Left_Shoulder/Left_Arm.visible = false
		$Polygons/Hip/Torso/Left_Shoulder/Left_Shoulder_Broken.visible = true
	if health <= 0:
		$Polygons/Hip/Torso/Head.visible = false
		anim.play("death")
		is_active = false
	modulate = Color(1.5, 1.5, 1.5)
	flash_timer = 0.16
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
