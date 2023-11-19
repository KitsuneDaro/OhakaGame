class_name Twitter

static func share(text: String):
	# http://twitter.com/intent/tweet?url=' + encodeURIComponent(this_url) + '&text=' + encodeURIComponent(text)
	OS.shell_open("http://twitter.com/intent/tweet?text=%s&url=%s" % [text, "https://kitsunedaro.github.io/OhakaGame/"])
