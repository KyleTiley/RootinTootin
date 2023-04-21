extends RichTextLabel

var shouldTime = false
var ms = 0
var s = 0
var m = 0

func _process(delta):
	
	if ms > 9:
		s += 1
		ms = 0
	
	if s > 59:
		m += 1
		s = 0
	
	if s > 9:
		text = str(m)+":"+str(s)+"."+str(ms)
	
	if s < 10:
		text = str(m)+":0"+str(s)+"."+str(ms)

func _on_Timer_timeout():
	if shouldTime:
		ms += 1

func _on_StartTrigger_start_timer():
	shouldTime = true


func _on_StopTrigger_stop_timer():
	shouldTime = false
