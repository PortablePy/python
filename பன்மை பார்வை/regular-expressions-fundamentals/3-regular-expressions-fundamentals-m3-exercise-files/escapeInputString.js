function escapeInputString( str ) {
	return str.replace(/[[\]\/\\{}()|?+^$*.-]/g, "\\$&");
}