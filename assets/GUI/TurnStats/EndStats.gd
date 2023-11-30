extends Popup

var chartsUI = preload("res://assets/GUI/TurnStats/ChartsUI.tscn")
var postUI = preload("res://assets/GUI/TurnStats/PostSurvey.tscn")

# Replace with API url here
var imgapiurl = "API for ImgBB here"

func _make_post_request(url, data_to_send, use_ssl):
	var query = JSON.print(data_to_send)
	var headers=["Content-Type: multipart/form-data;boundary=\"WebKitFormBoundaryePkpFF7tjBAqx29L\""]
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
	
	var image = File.new()
	
	#for troubleshooting
#	image.open("res://data/screenshot.png", File.READ)
	image.open(str("res://data/" + Global.imageSS), File.READ)

	var imageConverted = image.get_buffer(image.get_len())
	var body = PoolByteArray()
	body.append_array("\r\n--WebKitFormBoundaryePkpFF7tjBAqx29L\r\n".to_utf8())
	
	#for troubleshooting
#	body.append_array(str("Content-Disposition: form-data; name=\"image\"; filename=\"screenshot.png\r\n").to_utf8())
	body.append_array(str("Content-Disposition: form-data; name=\"image\"; filename=\"" + Global.imageSS + "\r\n").to_utf8())
	
	body.append_array("Content-Type: image/png\r\n\r\n".to_utf8())
	body.append_array(imageConverted)
	body.append_array("\r\n--WebKitFormBoundaryePkpFF7tjBAqx29L--\r\n".to_utf8())
	var headers = ["Authorization: Basic <key removed>", "Content-Type: multipart/form-data;boundary=\"WebKitFormBoundaryePkpFF7tjBAqx29L\""]
	var http = $HTTPRequest
	var err = http.request_raw(imgapiurl, headers, true, HTTPClient.METHOD_POST, body)
	yield(get_tree().create_timer(3), "timeout")
	add_child(postUI.instance())
	if has_node("PostSurvey"):
		get_node("PostSurvey").show()
	self.hide()

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var fullresponse = parse_json(body.get_string_from_utf8())
	Global.screenshotUrl = str(fullresponse.data.url)
	print(fullresponse.data.url)
