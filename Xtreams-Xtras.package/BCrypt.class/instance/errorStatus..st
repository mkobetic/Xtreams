private
errorStatus: status
	
	| msg |
	msg := String new writeStream.
	msg nextPutAll: 'Error 0x'.
	status printOn: msg base: 16.
	self error: msg contents