extends Node

@onready var textboxScene = preload("res://scenes/general/textbox.tscn")

var dialogLines: Array[String] =  []
var currentLineIndex = 0

var textbox
var textBoxPosition := Vector2 (0.0, 200.0)

var isDialogActive = false
var canAdvanceLine = false

func startDialog(lines: Array[String]):
	if isDialogActive:
		return
	
	dialogLines = lines
	showTextBox()
	
	isDialogActive = true

func showTextBox():
	textbox = textboxScene.instantiate()
	textbox.finishedDisplayingText.connect(onTextboxFinishedDisplaying)
	get_tree().root.add_child(textbox)
	textbox.global_position = textBoxPosition
	textbox.displayText(dialogLines[currentLineIndex])
	canAdvanceLine = false

func onTextboxFinishedDisplaying():
	canAdvanceLine = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and isDialogActive and canAdvanceLine:
		textbox.queue_free()
		currentLineIndex += 1
		
		if currentLineIndex > dialogLines.size() - 1:
			isDialogActive = false
			currentLineIndex = 0
			return
		
		showTextBox()
