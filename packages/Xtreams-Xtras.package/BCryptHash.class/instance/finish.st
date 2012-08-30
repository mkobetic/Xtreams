accessing
finish
	
	| md |
	md := ByteArray new: self digestSize.
	library finishHash: handle into: md.
	^md