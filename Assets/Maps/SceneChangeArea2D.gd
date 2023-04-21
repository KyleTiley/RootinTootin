extends Area2D

const pre_load_scene = preload("res://Regions/Game.tscn")

func _on_SceneChangeArea2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_packed(pre_load_scene)
