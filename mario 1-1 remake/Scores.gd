extends Label


func _process(delta):
	text = "Score\n" + str(Global.scores)
