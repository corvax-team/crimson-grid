/datum/tts_provider/silero
	name = "Silero"
	is_enabled = TRUE

/datum/tts_provider/silero/request(text, datum/tts_seed/silero/seed, datum/callback/proc_callback)
	if(throttle_check())
		return FALSE

	var/ssml_text = {"<speak>[text]</speak>"}

	var/list/req_body = list()

	req_body["api_token"] = CONFIG_GET(string/tts_token_silero)
	req_body["text"] = ssml_text
	req_body["sample_rate"] = 24000
	req_body["speaker"] = seed.value
	req_body["lang"] = "ru"
	req_body["remote_id"] = "[world.port]"
	req_body["format"] = "ogg"

	// json_encode writes TRUE as 1, strict API implementations accept only true/false
	var/body = json_encode(req_body)
	body = copytext(body, 1, length(body)) + {","ssml":true,"put_accent":true,"put_yo":false,"word_ts":false,"symbol_durs":\[]}"}

	SShttp.create_async_request(RUSTG_HTTP_METHOD_POST, CONFIG_GET(string/tts_api_url_silero), body, list("content-type" = "application/json"), proc_callback)

	return TRUE

/datum/tts_provider/silero/process_response(datum/http_response/response)
	if(!rustg_json_is_valid(response.body))
		return null
	var/list/data = json_decode(response.body)
	if(!islist(data))
		return null

	var/list/timings = data["timings"]
	if(islist(timings) && timings["003_tts_time"] > 3)
		is_throttled = TRUE
		throttled_until = world.time + 15 SECONDS

	var/list/results = data["results"]
	if(!length(results) || !islist(results[1]))
		return null
	return results[1]["audio"]

/datum/tts_provider/silero/pitch_whisper(text)
	return {"<prosody pitch="x-low">[text]</prosody>"}

/datum/tts_provider/silero/rate_faster(text)
	return {"<prosody rate="fast">[text]</prosody>"}

/datum/tts_provider/silero/rate_medium(text)
	return {"<prosody rate="medium">[text]</prosody>"}
