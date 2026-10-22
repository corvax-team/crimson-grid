/// Silero reads only Cyrillic, so Latin words are spelled out phonetically before synthesis
/proc/tts_latin_to_cyrillic(text)
	var/static/regex/latin_words = new(@"[a-zA-Z]+", "g")
	return replacetext(text, latin_words, GLOBAL_PROC_REF(tts_transliterate_word))

/proc/tts_transliterate_word(word)
	var/static/list/digraphs = list(
		"shch" = "щ",
		"sch" = "ск",
		"sh" = "ш",
		"ch" = "ч",
		"zh" = "ж",
		"kh" = "х",
		"th" = "т",
		"ph" = "ф",
		"ts" = "ц",
		"ck" = "к",
		"qu" = "кв",
		"yo" = "ё",
		"yu" = "ю",
		"ya" = "я",
		"ye" = "е",
		"ee" = "и",
		"oo" = "у",
	)
	var/static/list/letters = list(
		"a" = "а", "b" = "б", "c" = "к", "d" = "д", "e" = "е", "f" = "ф", "g" = "г",
		"h" = "х", "i" = "и", "j" = "дж", "k" = "к", "l" = "л", "m" = "м", "n" = "н",
		"o" = "о", "p" = "п", "q" = "к", "r" = "р", "s" = "с", "t" = "т", "u" = "у",
		"v" = "в", "w" = "в", "x" = "кс", "y" = "и", "z" = "з",
	)
	word = LOWER_TEXT(word)
	. = ""
	var/position = 1
	var/word_length = length(word)
	while(position <= word_length)
		var/matched = FALSE
		for(var/digraph in digraphs)
			var/digraph_length = length(digraph)
			if(copytext(word, position, position + digraph_length) == digraph)
				. += digraphs[digraph]
				position += digraph_length
				matched = TRUE
				break
		if(matched)
			continue
		. += letters[copytext(word, position, position + 1)]
		position++
