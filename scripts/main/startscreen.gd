extends Control


func _on_button_pressed() -> void:
	Globals.nextScene = "res://scenes/main/game.tscn"
	get_tree().change_scene_to_packed(Globals.loadingScreen)
