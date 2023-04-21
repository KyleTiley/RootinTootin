extends Label

func _on_Player_change_state(new_state_string, new_state_id):
	self.text = new_state_string
