extends Control

@export var correct_key: String = "192.168.31.127"


@onready var key_input = $KeyInput
@onready var message_label = $MessageLabel

func _ready():
	message_label.text = ""

func _on_SubmitButton_pressed():
	var entered = key_input.text.strip_edges()
	if entered == correct_key:
		message_label.text = "Access Granted!"
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/game3.tscn")
	else:
		message_label.text = "Access Denied!"
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/game2.tscn")


func _on_line_edit_text_submitted(new_text: String) -> void:
	pass # Replace with function body.
