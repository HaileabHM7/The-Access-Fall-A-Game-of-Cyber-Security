extends Area2D

@export var correct_key: String = "CyberSecurity"

# UI nodes under CanvasLayer
@onready var prompt_label = $CanvasLayer/Control/Label
@onready var key_input = $CanvasLayer/Control/LineEdit
@onready var collision_shape = $CollisionShape2D

var player_inside := false
var gate_opened := false

func _ready():
	prompt_label.text = ""          # nothing shown until player is nearby
	key_input.visible = false
	# optionally style prompt_label font size / anchor so it's visible center-bottom, etc.

# Area2D signal: connect "body_entered" to this function
func _on_body_entered(body):
	if gate_opened:
		return
	if body.is_in_group("Player"):
		player_inside = true
		prompt_label.text = "Press E to access"    # prompt to interact

# Area2D signal: connect "body_exited" to this function
func _on_body_exited(body):
	if body.is_in_group("Player"):
		player_inside = false
		prompt_label.text = ""
		key_input.visible = false
		key_input.text = ""

func _process(delta):
	if gate_opened:
		return
	if player_inside and Input.is_action_just_pressed("ui_accept") == false:
		# we will use a custom action "interact" instead of ui_accept (see below)
		pass

	# Show input when player presses the interact key (example: "interact" = E)
	if player_inside and Input.is_action_just_pressed("interact"):
		key_input.visible = true
		key_input.grab_focus()
		key_input.select_all()
		prompt_label.text = "Enter access key: (press Enter)"

# LineEdit signal: connect "text_submitted" to this function
func _on_line_edit_text_submitted(new_text: String):
	if gate_opened:
		return
	if new_text == correct_key:
		prompt_label.text = "Access Granted!"
		# disable the collision so the player can pass
		collision_shape.disabled = true
		gate_opened = true
		key_input.visible = false
	else:
		prompt_label.text = "Incorrect Key. Try again."
		key_input.text = ""
		key_input.grab_focus()

# optional: if you want ESC to close input without submitting
func _input(event):
	if key_input.visible and event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		key_input.visible = false
		prompt_label.text = "Press E to access"
