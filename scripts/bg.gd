extends ParallaxBackground

var scrollingSpeed = 20

func _process(delta):
	scroll_offset.x -= scrollingSpeed * delta
