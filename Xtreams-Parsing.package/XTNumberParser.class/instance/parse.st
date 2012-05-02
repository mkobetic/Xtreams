private
parse
	
	absolute := 0.
	[self parseSign.
	self parseDigits.
	self parseFraction]
		on: Incomplete
		do: [:nothing].
	^ absolute * sign