private
fillBufferIfRequired: anInteger
"
	If we have any data available in our buffer, return true. If not, attempt to fill up our buffer and return true if that worked. Try not to fill the buffer more than was originally requested (@anInteger), but we make sure we only fill up to what's available from our inner stream. We don't guarantee we'll fill our buffer up to @anInteger's worth, just that we'll attempt to fill the buffer.
"
	buffer ifNil: [^false].
	buffer hasDataToRead ifTrue: [^true].
	sourceAtEnd ifTrue: [^false].
	self fillBuffer: anInteger.
	^buffer hasDataToRead