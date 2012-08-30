open/close
open: fileName forWrite: writeMode 
	"Open the file with the given name. If writeMode is true, allow writing, otherwise
	open the file in read-only mode."

	self handle:
		((self primOpen: fileName writable: writeMode) ifNil: [^ nil]).  "allows sender to detect failure"
	writable := writeMode