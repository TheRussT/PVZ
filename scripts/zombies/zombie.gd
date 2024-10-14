extends Node2D

@onready var anim = $AnimationPlayer
var speed = 25
var health_max = 270
var health = 270
var is_active = true
var is_eating = false
var flash_timer = 0
var map = [0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0]
var row = 0
var curr_plant
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
		if is_eating:
			if(map[row*9+get_column()] == 0):
				is_eating = false
				anim.play("Walking")
			else:
				curr_plant.damage(0.833)
		else:
			var column = get_column()
			if (column < 0):
				pass #do game over
			if(column < 9 && map[row*9+column] == 1): #change once map rules are clear
				for p in get_node("/root/Level/TestMap/Plants").get_children():
					if(row == p.row_num && column == p.column_num):
						curr_plant = p
						is_eating = true
						anim.play("Eating")
						break
			else:
				position.x -= speed * delta
	else:
		if !anim.is_playing():
			get_node("/root/Level").update_zombie_count(-1)
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
	
func get_column():
	return (2000 + int(position.x) - 386) / 150

