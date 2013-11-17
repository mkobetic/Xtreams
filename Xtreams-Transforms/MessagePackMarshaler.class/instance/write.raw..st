"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: private - writing
"
write: writing raw: bytearray
	self write: writing raw_size: bytearray size.
	writing uint8 write: bytearray
