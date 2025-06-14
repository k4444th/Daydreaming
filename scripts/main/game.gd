extends Node

@onready var playerNode = $Player

const testLines: Array[String] = [
	"Hey, how are you?",
	"You are new in town, aren't you?",
	"Welcome! Nice to meet you!"
]

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Interact"):
		Dialogmanager.startDialog(testLines)
