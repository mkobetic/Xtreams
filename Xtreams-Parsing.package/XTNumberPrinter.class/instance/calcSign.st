private
calcSign
	number negative ifTrue:
		[sign := $-.
		number := number negated]