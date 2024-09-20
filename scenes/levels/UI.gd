extends CanvasLayer

var curr_plant
var curr_control
var plant1
var control1
var plant2
var control2

func _ready():
	print("instance from UI")
	plant1 = load("res://scenes/plants/peashooter.tscn").instantiate()
	plant1.set_name("DragPlant0")
	plant1.visible = false
	control1 = Control.new()
	control1.add_child(plant1, true)
	control1.set_name("PlantPreview0")
	add_child(control1, true)
	move_child(get_node("PlantPreview0"), 0)
	
	plant2 = load("res://scenes/plants/sunflower.tscn").instantiate()
	plant2.set_name("DragPlant1")
	plant2.visible = false
	control2 = Control.new()
	control2.add_child(plant2, true)
	control2.set_name("PlantPreview1")
	add_child(control2, true)
	move_child(get_node("PlantPreview1"), 0)

func set_plant_preview(tower_type, mouse_position, idx):
	print(idx)
	curr_control = get_node("PlantPreview" + str(idx))
	curr_plant = curr_control.get_child(0)
	curr_plant.visible = true
	curr_control.set_position(mouse_position)
	
	#plant1.visible = true
	#control1.set_position(mouse_position)
	
	#var drag_plant = load("res://scenes/plants/" + tower_type + ".tscn").instantiate()
	#drag_plant.set_name("DragPlant")
	#drag_plant.modulate = Color("ad54ff")
	#var control = Control.new()
	#control.add_child(drag_plant, true)
	#control.set_position(mouse_position)
	#control.set_name("PlantPreview")
	#add_child(control, true)
	#move_child(get_node("PlantPreview"), 0)

func update_plant_preview(new_position, color):
	curr_control.set_position(new_position)
	#if get_node("PlantPreview/DragPlant").modulate != Color(color):
	#	get_node("PlantPreview/DragPlant").modulate = Color(color)

func destroy_plant_preview():
	curr_plant.visible = false
