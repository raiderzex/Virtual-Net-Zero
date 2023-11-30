extends Node

var selected_module_index;
var selected_module_name;
var total_cost : int;
var remaining;
var turn_count = 1;
var budget_list = [75000000, 75000000, 75000000, 75000000, 75000000,
	75000000, 75000000, 75000000, 75000000, 75000000,
	75000000, 75000000, 75000000, 75000000, 75000000,
	75000000, 75000000, 75000000, 75000000, 75000000,
	75000000, 75000000, 75000000, 75000000, 75000000,
	75000000, 75000000, 75000000, 75000000, 75000000];
var activity_score : float
var population_score : float
var vibrancy : float

var carbonScoreList = [0]
var waterScoreList = [0]
var foodScoreList = [0]
var energyScoreList = [0]
var vibrancyScoreList = [0]
var turnList = [0]

var embodiedCarbon : int;
var operationalCarbon : int;

var energyConsumption : int;

var waterConsumption : int;
var waterCaptured : int;

var foodConsumption : int;
var foodProduction : int;

var bridgeDirection: int = 1;

var takeScreenshot: bool = false;
var imageSS;
var screenshotUrl;

func _process(delta):
	remaining = int(Global.budget_list[int(turn_count - 1)])
	if population_score > 0:
		vibrancy = float(activity_score / population_score)
	else:
		vibrancy = 0
	
