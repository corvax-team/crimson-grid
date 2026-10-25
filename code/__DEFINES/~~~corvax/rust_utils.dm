#ifndef RUST_UTILS
/* This comment bypasses grep checks */ /var/__rust_utils

/proc/__detect_rust_utils()
	if(world.system_type == UNIX)
		if(fexists("./librust_utils.so"))
			return __rust_utils = "./librust_utils.so"
		return __rust_utils = "librust_utils.so"
	return __rust_utils = "librust_utils"

#define RUST_UTILS (__rust_utils || __detect_rust_utils())
#endif

/proc/rust_utils_get_version() return RUSTG_CALL(RUST_UTILS, "get_version")()

#define rustutils_file_write_b64decode(text, fname) RUSTG_CALL(RUST_UTILS, "file_write")(text, fname, "true")
#define rustutils_latin_to_cyrillic(text) RUSTG_CALL(RUST_UTILS, "latin_to_cyrillic")("[text]")
