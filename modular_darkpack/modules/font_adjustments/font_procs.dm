//this file holds text and character replacement stuff, like the malk madness speech
/proc/spooky_font_replace(input) //mostly used for malkavians
	if(!input)
		input = " "
		CRASH("spooky_font_replace called without input!")

	var/list/replacements = list(
			"a"    = "𝙖",                  "A" = "𝘼",
			"d"    = pick("𝓭","𝓓"),       "D" = "𝓓",
			"e"    = "𝙚",                  "E" = "𝙀",
			"i"    = "𝙞",                  "I" = pick("ﾉ", "𝐼"),
			"l"    = pick("𝙇", "l", "\\"), "L" = pick("𝙇", "𝓛","\\"),
			"n"    = "𝙣",                  "N" = pick("𝓝", "𝙉"),
			"o"    = "𝙤",                  "O" = "𝙊",
			"s"    = "𝘴",                  "S" = "𝙎",
			"u"    = "𝙪",                  "U" = "𝙐",
			"v"	   = "𝐯",                  "V" = "𝓥",
			"а"    = "𝙖",                  "А" = "𝘼",
			"е"    = "𝙚",                  "Е" = "𝙀",
			"о"    = "𝙤",                  "О" = "𝙊",
			"с"    = "𝙘",                  "С" = "𝘾",
			"р"    = "𝙥",                  "Р" = "𝙋",
			"х"    = "𝙭",                  "Х" = "𝙓",
			"и"    = "𝙪",                  "В" = "𝘽",
			"п"    = "𝙣",                  "Н" = "𝙃",
			"т"    = "𝙢",                  "Т" = "𝙏",
			"К"    = "𝙆",                  "М" = "𝙈",
		)
	for(var/letter in replacements)
		input = replacetextEx(input, letter, replacements[letter])
	return input
