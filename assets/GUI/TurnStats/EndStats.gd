extends Popup

var chartsUI = preload("res://assets/GUI/TurnStats/ChartsUI.tscn")
var postUI = preload("res://assets/GUI/TurnStats/PostSurvey.tscn")

var image = load("res://data/screenshot.png")
var imageConverted

# Replace with API url here
var imgapiurl = "IMGBB API"

func _make_post_request(url, data_to_send, use_ssl):
	var query = JSON.print(data_to_send)
	print(query)
	var headers=["Content-Type: multipart/form-data"]
	$HTTPRequest.request(url, headers, true, HTTPClient.METHOD_POST, query)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.show() # Replace with function body.
#	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_StatsButton_button_up():
	add_child(chartsUI.instance())
	if has_node("ChartsUI"):
		get_node("ChartsUI").show()

func _on_CloseButton_button_up():
	imageConverted = Marshalls.variant_to_base64(image, true)
	print(imageConverted)
	_make_post_request(imgapiurl, imageConverted, false)
	add_child(postUI.instance())
	if has_node("PostSurvey"):
		get_node("PostSurvey").show()
	self.hide()

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(body.get_string_from_utf8())
