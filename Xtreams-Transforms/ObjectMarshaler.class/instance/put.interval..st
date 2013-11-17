"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing interval: interval
	<writes: 'Core.Interval'>

	self marshal: writing object: interval first.
	self marshal: writing object: interval last.
	self marshal: writing object: interval increment
