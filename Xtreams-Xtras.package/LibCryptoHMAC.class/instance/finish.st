accessing
finish
	
	| md |
	algorithm ifNil: [^nil].
	md := ByteArray new: self digestSize.
	self HMAC_Final: context with: md with: nil.
	^md