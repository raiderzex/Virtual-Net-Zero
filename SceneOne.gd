extends Spatial

onready var ray = $SelectionTool/RayCast
onready var map = $GameBoard
onready var camera = $OrbitCamera
onready var selection_cube = $SelectionTool/MeshInstance
onready var MeshLib = $GameBoard.get_mesh_library()

var can_build = true
var has_module = false
var mouse_pos
var point
var selection_position
var ray_length = 2000

export (Color, RGB) var green
export (Color, RGB) var red
export (Color, RGB) var transparent

func _process(delta):
	mouse_pos = get_viewport().get_mouse_position()
	var from = get_viewport().get_camera().project_ray_origin(mouse_pos)
	var to = get_viewport().get_camera().project_ray_normal(mouse_pos) * ray_length

	ray.transform.origin = from
	ray.cast_to = to
	ray.force_raycast_update()
	# Collision point translated into gridmap coordinates
	point = map.world_to_map(ray.get_collision_point())
	var tile = map.get_cell_item(point.x, point.y - 0.5, point.z)
#	print("ray collide is " + str(ray.is_colliding()))
#	print("can build is " + str(can_build))
#	print("tile is " + str(tile))
#	print(point)
#	print(ray.get_collider())

	# Set tool color
	if tile == 0 or tile == 5 or tile == 6 or tile == 8 or tile == 13 or tile == 18:
		selection_cube.get_surface_material(0).set_shader_param("current_color", green)
		selection_cube.get_surface_material(0).set_shader_param("transparency", 0.5)
		can_build = true
	else:
		selection_cube.get_surface_material(0).set_shader_param("current_color", red)
		selection_cube.get_surface_material(0).set_shader_param("transparency", 0.5)
		can_build = false
		
	if not ray.is_colliding():
		can_build = false
		selection_cube.get_surface_material(0).set_shader_param("transparency", 0)

	# Move Selection Box
	selection_position = map.map_to_world(point.x, point.y, point.z)
	var sel_cube_pos = selection_position
	sel_cube_pos.y += 2.5
	if ray.is_colliding():
		selection_cube.translation = sel_cube_pos
	
	var selected_module = str(Global.selected_module_name)
	var selected_index
	if selected_module != null:
		selected_index = int(MeshLib.find_item_by_name(selected_module))
	else:
		selected_index = -1
	
	for i in range(GameData.item_data.size()):
		if str(GameData.item_data[str(i)]["Name"]) == selected_module:
			var added_cost = int(GameData.item_data[str(i)]["Cost"])
			if int(Global.remaining - added_cost) < 0:
				selection_cube.get_surface_material(0).set_shader_param("current_color", red)
				selection_cube.get_surface_material(0).set_shader_param("transparency", 0.5)
				can_build = false
	
	if can_build:
		if selected_index != -1:
			var start_pos : Vector2
			var end_pos : Vector2
			start_pos.x = floor(mouse_pos.x / 20)
			start_pos.y = floor(mouse_pos.y / 20)
			if Input.is_action_just_released("leftclick"):
				end_pos.x = floor(mouse_pos.x / 20)
				end_pos.y = floor(mouse_pos.y / 20)
#				print("end pos is " + str(end_pos))
#				print(start_pos.distance_to(end_pos))
				if start_pos.distance_to(end_pos) < 1:
					if selected_index != 13:
						_place_module(selected_index, selection_position, selected_module)
					if selected_index == 13:
						_place_bridge_module(selected_index, selection_position, selected_module, Global.bridgeDirection)
#					print(Global.total_cost)
	
	if tile != 0 or tile != 1 or tile != 2:
		if Input.is_action_just_released("rightclick"):
			_remove_module(selection_position, tile)
#			print(Global.total_cost)

		
	
func _place_module(index : int, position : Vector3, indexcost : String):
	var item_above = map.get_cell_item(position.x / 20, (position.y / 5) , (position.z / 20) - 1)
	if item_above == -1:
		map.set_cell_item(position.x / 20, (position.y / 5) , (position.z / 20) - 1, index)
		for i in range(GameData.item_data.size()):
			if str(GameData.item_data[str(i)]["Name"]) == indexcost:
				
				# Add to total cost
				var added_cost = int(GameData.item_data[str(i)]["Cost"])
				Global.total_cost += added_cost
				Global.budget_list[int(Global.turn_count - 1)] -= added_cost
				print(Global.budget_list[int(Global.turn_count - 1)])
				
				# Add activity score
				Global.activity_score += int(GameData.item_data[str(i)]["ActivityScore"])
				
				# Add population score if applicable
				if GameData.item_data[str(i)]["PopulationScore"]:
					print(GameData.item_data[str(i)]["PopulationScore"])
					Global.population_score += int(GameData.item_data[str(i)]["PopulationScore"])
					
				# Add carbon footprint values
				if GameData.item_data[str(i)]["EmbodiedCarbon"]:
					Global.embodiedCarbon += int(GameData.item_data[str(i)]["EmbodiedCarbon"])
				if GameData.item_data[str(i)]["OperationalCarbon"]:
					Global.operationalCarbon += int(GameData.item_data[str(i)]["OperationalCarbon"])
					
				# Add energy produced/consumed values
				if GameData.item_data[str(i)]["EnergyProduced"]:
					Global.energyConsumption -= int(GameData.item_data[str(i)]["EnergyProduced"])
				if GameData.item_data[str(i)]["EnergyConsumed"]:
					Global.energyConsumption += int(GameData.item_data[str(i)]["EnergyConsumed"])
					
				# Add water consumption values
				if GameData.item_data[str(i)]["WaterCaptured"]:
					Global.waterConsumption -= int(GameData.item_data[str(i)]["WaterCaptured"])
				if GameData.item_data[str(i)]["WaterConsumed"]:
					Global.waterConsumption += int(GameData.item_data[str(i)]["WaterConsumed"])
					
				# Add food produced/consumed values
				# foodInput is for processing, foodProduction is for produced raw food
				if GameData.item_data[str(i)]["FoodProduced"]:
					Global.foodConsumption -= int(GameData.item_data[str(i)]["FoodProduced"])
				if GameData.item_data[str(i)]["FoodConsumed"]:
					Global.foodConsumption += int(GameData.item_data[str(i)]["FoodConsumed"])
					
				# Test prints
				print(Global.vibrancy)
	
	
func _place_bridge_module(index : int, position : Vector3, indexcost : String, direction : int):
	var item_above = map.get_cell_item(position.x / 20, (position.y / 5) , (position.z / 20) - 1)
	var item_front = map.get_cell_item((position.x / 20), (position.y / 5) - 1 , (position.z / 20) - 2)
	var item_back = map.get_cell_item((position.x / 20), (position.y / 5) - 1 , (position.z / 20))
	var item_left = map.get_cell_item((position.x / 20) - 1, (position.y / 5) - 1 , (position.z / 20) - 1)
	var item_right = map.get_cell_item((position.x / 20) + 1, (position.y / 5) - 1 , (position.z / 20) - 1)
	if item_above == -1 and floor( position.y / 5 ) > 1:
		match direction:
			1:
				if item_front == -1:
					map.set_cell_item((position.x / 20), (position.y / 5) - 1 , (position.z / 20) - 2 , index)
					print(Global.bridgeDirection)
					for i in range(GameData.item_data.size()):
						if str(GameData.item_data[str(i)]["Name"]) == indexcost:
							
							# Add to total cost
							var added_cost = int(GameData.item_data[str(i)]["Cost"])
							Global.total_cost += added_cost
							Global.budget_list[int(Global.turn_count - 1)] -= added_cost
							print(Global.budget_list[int(Global.turn_count - 1)])
							
							# Add activity score
							Global.activity_score += int(GameData.item_data[str(i)]["ActivityScore"])
							
							# Add carbon footprint values
							if GameData.item_data[str(i)]["EmbodiedCarbon"]:
								Global.embodiedCarbon += int(GameData.item_data[str(i)]["EmbodiedCarbon"])
							if GameData.item_data[str(i)]["OperationalCarbon"]:
								Global.operationalCarbon += int(GameData.item_data[str(i)]["OperationalCarbon"])
				else:
					pass
			2:
				if item_back == -1:
					map.set_cell_item((position.x / 20), (position.y / 5) - 1 , (position.z / 20), index)
					print(Global.bridgeDirection)
					for i in range(GameData.item_data.size()):
						if str(GameData.item_data[str(i)]["Name"]) == indexcost:
							
							# Add to total cost
							var added_cost = int(GameData.item_data[str(i)]["Cost"])
							Global.total_cost += added_cost
							Global.budget_list[int(Global.turn_count - 1)] -= added_cost
							print(Global.budget_list[int(Global.turn_count - 1)])
							
							# Add activity score
							Global.activity_score += int(GameData.item_data[str(i)]["ActivityScore"])
							
							# Add carbon footprint values
							if GameData.item_data[str(i)]["EmbodiedCarbon"]:
								Global.embodiedCarbon += int(GameData.item_data[str(i)]["EmbodiedCarbon"])
							if GameData.item_data[str(i)]["OperationalCarbon"]:
								Global.operationalCarbon += int(GameData.item_data[str(i)]["OperationalCarbon"])
				else:
					pass
			3:
				if item_left == -1:
					map.set_cell_item((position.x / 20) - 1, (position.y / 5) - 1 , (position.z / 20) - 1, index)
					for i in range(GameData.item_data.size()):
						if str(GameData.item_data[str(i)]["Name"]) == indexcost:
							
							# Add to total cost
							var added_cost = int(GameData.item_data[str(i)]["Cost"])
							Global.total_cost += added_cost
							Global.budget_list[int(Global.turn_count - 1)] -= added_cost
							print(Global.budget_list[int(Global.turn_count - 1)])
							
							# Add activity score
							Global.activity_score += int(GameData.item_data[str(i)]["ActivityScore"])
							
							# Add carbon footprint values
							if GameData.item_data[str(i)]["EmbodiedCarbon"]:
								Global.embodiedCarbon += int(GameData.item_data[str(i)]["EmbodiedCarbon"])
							if GameData.item_data[str(i)]["OperationalCarbon"]:
								Global.operationalCarbon += int(GameData.item_data[str(i)]["OperationalCarbon"])
				else:
					pass
			4:
				if item_right == -1:
					map.set_cell_item((position.x / 20) + 1, (position.y / 5) - 1 , (position.z / 20) - 1, index)
					for i in range(GameData.item_data.size()):
						if str(GameData.item_data[str(i)]["Name"]) == indexcost:
							
							# Add to total cost
							var added_cost = int(GameData.item_data[str(i)]["Cost"])
							Global.total_cost += added_cost
							Global.budget_list[int(Global.turn_count - 1)] -= added_cost
							print(Global.budget_list[int(Global.turn_count - 1)])
							
							# Add activity score
							Global.activity_score += int(GameData.item_data[str(i)]["ActivityScore"])
							
							# Add carbon footprint values
							if GameData.item_data[str(i)]["EmbodiedCarbon"]:
								Global.embodiedCarbon += int(GameData.item_data[str(i)]["EmbodiedCarbon"])
							if GameData.item_data[str(i)]["OperationalCarbon"]:
								Global.operationalCarbon += int(GameData.item_data[str(i)]["OperationalCarbon"])
				else:
					pass

				
func _remove_module(position : Vector3, indexmesh : int):
	if floor( position.y / 5 ) > 1:
		var item_above = map.get_cell_item(position.x / 20, (position.y / 5) + 1 , (position.z / 20) - 1)
		if item_above == -1:
			map.set_cell_item((position.x / 20), (position.y / 5) - 1, (position.z / 20) - 1, -1)
			var indexcost = str(MeshLib.get_item_name(indexmesh))
			for i in range(GameData.item_data.size()):
				if str(GameData.item_data[str(i)]["Name"]) == indexcost:
					
					# Subtract from total cost
					var added_cost = int(GameData.item_data[str(i)]["Cost"])
					if Global.budget_list[int(Global.turn_count - 1)] + added_cost <= 75000000:
						Global.total_cost -= added_cost
						Global.budget_list[int(Global.turn_count - 1)] += added_cost
					else:
						Global.budget_list[int(Global.turn_count - 1)] = 75000000
					print(Global.budget_list[int(Global.turn_count - 1)])
					
					# Subtract activity score
					Global.activity_score -= int(GameData.item_data[str(i)]["ActivityScore"])
					
					# Subtract population score if applicable
					if GameData.item_data[str(i)]["PopulationScore"]:
						print(GameData.item_data[str(i)]["PopulationScore"])
						Global.population_score -= int(GameData.item_data[str(i)]["PopulationScore"])
						
					# Subtract carbon footprint values
					if GameData.item_data[str(i)]["EmbodiedCarbon"]:
						Global.embodiedCarbon -= int(GameData.item_data[str(i)]["EmbodiedCarbon"])
					if GameData.item_data[str(i)]["OperationalCarbon"]:
						Global.operationalCarbon -= int(GameData.item_data[str(i)]["OperationalCarbon"])
						
					# Subtract energy produced/consumed values
					if GameData.item_data[str(i)]["EnergyProduced"]:
						Global.energyConsumption += int(GameData.item_data[str(i)]["EnergyProduced"])
					if GameData.item_data[str(i)]["EnergyConsumed"]:
						Global.energyConsumption -= int(GameData.item_data[str(i)]["EnergyConsumed"])
					
					# Subtract water consumption values
					if GameData.item_data[str(i)]["WaterCaptured"]:
						Global.waterConsumption += int(GameData.item_data[str(i)]["WaterCaptured"])
					if GameData.item_data[str(i)]["WaterConsumed"]:
						Global.waterConsumption -= int(GameData.item_data[str(i)]["WaterConsumed"])
					
					# Subtract food produced/consumed values
					if GameData.item_data[str(i)]["FoodProduced"]:
						Global.foodConsumption += int(GameData.item_data[str(i)]["FoodProduced"])
					if GameData.item_data[str(i)]["FoodConsumed"]:
						Global.foodConsumption -= int(GameData.item_data[str(i)]["FoodConsumed"])
					# Test prints
					print(Global.vibrancy)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
