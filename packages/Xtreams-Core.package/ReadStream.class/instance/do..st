enumerating
do: aBlock
	"Read from the stream and pass the read objects to the #do: block one by one until it reaches the end of stream."
	"	aBlock	<BlockClosure>	#do: style block evaluated with each element
	"
	[[aBlock cull: self get] repeat] on: Incomplete do: [:ex |]