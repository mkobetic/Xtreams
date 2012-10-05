queries
isValid
	"Return true if this socket contains a valid, non-nil socket handle."

	^ self connectionStatus ~= InvalidSocket

