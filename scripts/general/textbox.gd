extends MarginContainer

@onready var label = $MarginContainer/Label
@onready var timer = $LetterDisplayTimer

signal finishedDisplayingText()

var MAX_WIDTH = 1024

var text := ""
var letterIndex = 0

var letterTime = 0.03
var spaceTime = 0.06
var punctuationTime = 0.2

func displayText(textToDisplay):
	text = textToDisplay
	label.text = textToDisplay
	await resized
	custom_minimum_size.x = min(size.x, MAX_WIDTH)
	
	if size.x  > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # resize x
		await resized # resize y
		custom_minimum_size.y = size.y
	
	global_position.x -= size.x / 2
	
	label.text = ""
	displayLetter()

func displayLetter():
	label.text += text[letterIndex]
	letterIndex += 1
	if letterIndex > text.length() - 1:
		finishedDisplayingText.emit()
		return
	
	match text[letterIndex]:
		"!", ".", ",", "?":
			timer.start(punctuationTime)
		" ":
			timer.start(spaceTime)
		_:
			timer.start(letterTime)

func _on_letter_display_timer_timeout() -> void:
	displayLetter()
