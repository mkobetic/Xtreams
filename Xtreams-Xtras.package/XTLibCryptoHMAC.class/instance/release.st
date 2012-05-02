initialize-release
release
	
	context ifNil: [^self].
	self HMAC_CTX_cleanup: context.
	context free.
	context := nil