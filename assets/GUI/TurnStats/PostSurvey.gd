extends Popup

onready var http = $HTTPRequest
#Replace with sheet name from your Google Spreadsheet for data exporting
var sheetname = "Sheet1"
var carbonScore = str(Global.embodiedCarbon + Global.operationalCarbon)
var energyScore = str(Global.energyConsumption)
var waterScore = str(Global.waterConsumption)
var foodScore = str(Global.foodConsumption)
var vibrancyScore = str(Global.vibrancy)
var surveyqn1 = "Yes"
var surveyqn2 = "Yes"
var otherqn = ""

# Replace with API url here
var apiurl = "API_KEY"
var geturl = apiurl + "?sheetname=" + sheetname


# Called when the node enters the scene tree for the first time.
func _ready():
	self.show()
	print(carbonScore, energyScore, waterScore, foodScore, vibrancyScore)

func _on_Q1A_item_selected(index):
	match index: 
		0:
			surveyqn1 = "Yes"
		1:
			surveyqn1 = "No"


func _on_Q2A_item_selected(index):
	match index: 
		0:
			surveyqn1 = "Yes"
		1:
			surveyqn1 = "No"
			

func _on_Q3A_text_changed():
	otherqn = str($N/M/V/Q3A.get_text().replace(" ", "%20"))
	if $N/M/V/Q3A.text.length() == 0:
		otherqn = "null"

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8())

func _on_CloseButton_button_up():
	if $N/M/V/Q3A.text.length() == 0:
		otherqn = "null"
	var datasend = "?carbonScore="+carbonScore+"&energyScore="+energyScore+"&waterScore="+waterScore+"&foodScore="+foodScore+"&vibrancyScore="+vibrancyScore+"&surveyqn1="+surveyqn1+"&surveyqn2="+surveyqn2+"&otherqn="+otherqn+"&image="+Global.screenshotUrl+"&sheetname=EndGameData"
	var headers = ["Content-Length: 0"]
	var posturl = apiurl+datasend
	$HTTPRequest.request(posturl,headers,true,HTTPClient.METHOD_POST)
	print("Done")
	yield(get_tree().create_timer(5), "timeout")
	get_tree().quit()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


