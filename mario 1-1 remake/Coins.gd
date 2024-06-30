extends Label


func _process(delta):
	text = "Coins\n" + str(Global.coins)
