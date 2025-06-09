extends Node

@onready var progressBar = $CanvasLayer/ProgressBar

func _ready() -> void:
	ResourceLoader.load_threaded_request(Globals.nextScene)

func _process(_delta: float) -> void:
	var progress = []
	ResourceLoader.load_threaded_get_status(Globals.nextScene, progress)
	progressBar.value = progress[0] * 100
	
	if progress[0] == 1.0:
		var packedScene = ResourceLoader.load_threaded_get(Globals.nextScene)
		get_tree().change_scene_to_packed(packedScene)
