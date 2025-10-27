extends Control

@onready var key_input = $KeyInput
@onready var message_label = $MessageLabel

func _ready():
	message_label.text = ""

func _on_submit_button_pressed():
	var entered = key_input.text.strip_edges()

	# Deny if entered is "12345678" or "87654321"
	if entered == "12345678" or entered == "87654321":
		message_label.text = "Access Denied!"
		await get_tree().create_timer(1.0).timeout
	else:
		message_label.text = "Access Granted!"
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/game4.tscn")

func _on_key_input_text_submitted(new_text: String) -> void:
	_on_submit_button_pressed()
