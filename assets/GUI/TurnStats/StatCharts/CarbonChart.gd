extends Control

onready var chart: Chart = $N/M/V/Chart

# This Chart will plot 3 different functions
var f1: Function
var f2: Function
var f3: Function

func _ready():
	# Let's create our @x values
#	var x: Array = [2023, 2024, 2025, 2026]
	var x: Array = Global.turnList
	
	# And our y values. It can be an n-size array of arrays.
	# NOTE: `x.size() == y.size()` or `x.size() == y[n].size()`
#	var y: Array = [32400, 567000, 12340, -7560]
	var y: Array = Global.carbonScoreList

	# Let's customize the chart properties, which specify how the chart
	# should look, plus some additional elements like labels, the scale, etc...
	var cp: ChartProperties = ChartProperties.new()
	cp.colors.frame = Color("#454545")
	cp.colors.background = Color.transparent
	cp.colors.grid = Color("#283442")
	cp.colors.ticks = Color("#283442")
	cp.colors.text = Color.whitesmoke
	cp.draw_bounding_box = false
	cp.title = "Statistics Trends"
	cp.x_label = "Turn"
	cp.y_label = "Carbon (kgCO2eq)"
	cp.x_scale = x.size() - 1
	cp.y_scale = 10
	cp.interactive = true # false by default, it allows the chart to create a tooltip to show point values
	# and interecept clicks on the plot
	cp.show_legend = true
	
	# Let's add values to our functions
	f1 = Function.new(
		x, y, "Carbon", # This will create a function with x and y values taken by the Arrays 
						  # we have created previously. This function will also be named "Pressure"
						  # as it contains 'pressure' values.
						  # If set, the name of a function will be used both in the Legend
						  # (if enabled thourgh ChartProperties) and on the Tooltip (if enabled).
		# Let's also provide a dictionary of configuration parameters for this specific function.
		{ 
			color = Color("#36a2eb"), 		# The color associated to this function
			marker = Function.Marker.NONE, 	# The marker that will be displayed for each drawn point (x,y)
											# since it is `NONE`, no marker will be shown.
			type = Function.Type.LINE, 		# This defines what kind of plotting will be used, 
											# in this case it will be an Area Chart.
			interpolation = Function.Interpolation.LINEAR	# Interpolation mode, only used for 
															# Line Charts and Area Charts.
		}
	)
	
	# Now let's plot our data
	chart.plot([f1], cp)
	
	# Uncommenting this line will show how real time data plotting works
	set_process(false)
#


func _on_CloseButton_button_up():
	queue_free()
