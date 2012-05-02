private
parseFraction
	| scale |
	
	ch = $. ifTrue:
		[ch := in get.
		scale := 1.
		self parseDigits: 
			[:value | 
			scale := scale / base.
			value * scale + absolute]]