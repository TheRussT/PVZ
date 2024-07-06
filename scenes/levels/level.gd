extends Node2D

var map_node 

var build_mode= false
var build_valid = false 
var build_location
var build_type
var new_tower

var map_layout = [0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0]
#var tile_node
var curr_idx

func _ready():
	map_node = get_node("TestMap")
	#tile_node = get_node("TestMap/Tiles")
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.pressed.connect(initiate_build_mode.bind(i.name))
	
func _process(delta):
	if build_mode:
		update_plant_preview()
	
func _unhandled_input(event):
	if event.is_action_released("ui_cancel") and build_mode == true:
		#print("undo click")
		cancel_build_mode(true)
	if event.is_action_released("ui_accept") and build_mode == true:
		#print("clicky click")
		verify_and_build()
		cancel_build_mode(false)
	
func initiate_build_mode(plant_type):
	print("build attampt made")
	if !build_mode:
		#print("build successful")
		build_type = plant_type #+ "T1"
		build_mode = true 
		get_node("UI").set_plant_preview(build_type, get_global_mouse_position())
		#print("instance from build mode initiation")
		new_tower = load("res://scenes/plants/" + build_type + ".tscn").instantiate()
		map_node.get_node("Plants").add_child(new_tower, true)
		new_tower.start_placement()
		new_tower.visible = false

func update_plant_preview():
	var mouse_position = get_global_mouse_position()
	#var current_tile = map_node.get_node("PlantExclusion").local_to_map(mouse_position)
	#var title_position = map_node.get_node("PlantExclusion").map_to_local(current_tile)
	
	#if map_node.get_node("PlantExclusion").get_cell_source_id(0, current_tile):
	#	get_node("UI").update_plant_preview(title_position, "fff")
	#	build_valid = true 
	#	build_location = title_position
	
	#else:
	#	get_node("UI").update_plant_preview(title_position, "000")
	#	build_valid = false
	#	
	get_node("UI").update_plant_preview(mouse_position, "fff")
	var yoffset = 190
	var xoffset = 286
	update_tile_snap(0, 0, false)
	build_valid = false
	for i in 45:
		if(mouse_position.x > xoffset + (150 * (i%9) + 3) && mouse_position.x < xoffset + 150 + (150 * (i%9) - 3) &&
		mouse_position.y > yoffset + (150 * (i/9) + 3) && mouse_position.y < yoffset + 150 + (150 * (i/9)) - 3):
			#print("tile number ", i, " ", mouse_position)
			if(map_layout[i] == 0):
				curr_idx = i
				update_tile_snap(286 + 150*(i%9) + 75, 190 + 150*(i/9) + 100, true)
				build_valid = true
				break

func cancel_build_mode(with_clear):
	#print("exiting build mode")
	build_mode = false 
	build_valid = false 
	if with_clear:
		new_tower.queue_free()
	get_node("UI").destroy_plant_preview()
	
func verify_and_build():
	if build_valid:
		#print("built")
		map_layout[curr_idx] = 1
		new_tower.visible = true
		new_tower.stop_placement()
		map_node.get_node("Plants").add_child(new_tower, true)

func update_tile_snap(xpos, ypos, isvisible):
	new_tower.visible = isvisible
	new_tower.position.x = xpos
	new_tower.position.y = ypos
