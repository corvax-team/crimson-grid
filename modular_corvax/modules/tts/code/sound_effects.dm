#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

/proc/apply_sound_effects(list/effects, filename_input, filename_output)
	if(!length(effects))
		CRASH("Invalid sound effect chosen.")

	var/list/ffmpeg_arguments = list()
	var/complex = FALSE
	for(var/datum/tts_sound_effect/effect as anything in effects)
		if(effect.complex)
			ffmpeg_arguments = list(effect.ffmpeg_arguments)
			complex = TRUE
			break

		ffmpeg_arguments |= effect.ffmpeg_arguments

	var/taskset = CONFIG_GET(string/ffmpeg_cpuaffinity) ? "taskset -ac [CONFIG_GET(string/ffmpeg_cpuaffinity)]" : ""
	var/filter_part = complex ? ffmpeg_arguments.Join() : {"-filter:a "[ffmpeg_arguments.Join(", ")]""}

	var/command = {"[taskset] ffmpeg -y -hide_banner -loglevel error -i [filename_input] [filter_part] [filename_output]"}
	var/list/output = world.shelleo(command)

	var/errorlevel = output[SHELLEO_ERRORLEVEL]
	var/stdout = output[SHELLEO_STDOUT]
	var/stderr = output[SHELLEO_STDERR]
	if(errorlevel)
		var/effect_types = effects.Join("; ")
		log_runtime("Error: apply_sound_effects([effect_types], [filename_input], [filename_output]) - See debug logs.")
		logger.Log(LOG_CATEGORY_DEBUG, "apply_sound_effects([effect_types], [filename_input], [filename_output]) STDOUT: [stdout]")
		logger.Log(LOG_CATEGORY_DEBUG, "apply_sound_effects([effect_types], [filename_input], [filename_output]) STDERR: [stderr]")
		return FALSE

	return TRUE

/datum/tts_sound_effect
	/// If set to TRUE, this effect will ignore all other filters.
	var/complex = FALSE
	/// Text suffix used for caching file with specific effects.
	var/suffix
	/// Filter arguments passed to ffmpeg.
	var/ffmpeg_arguments

/datum/tts_sound_effect/radio
	suffix = "_radio"
	ffmpeg_arguments = "highpass=f=1000, lowpass=f=3000, acrusher=1:1:50:0:log"

/datum/tts_sound_effect/megaphone
	suffix = "_megaphone"
	ffmpeg_arguments = "highpass=f=500, lowpass=f=4000, volume=volume=10, acrusher=1:1:45:0:log"

#undef SHELLEO_ERRORLEVEL
#undef SHELLEO_STDOUT
#undef SHELLEO_STDERR
