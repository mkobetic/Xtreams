"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: class initialization
"
initialize
	| newSelf |
	newSelf := self new.
	#(#'latin-1' #latin1 #iso8859L1 #ISO8859L1) do: [:id | self encoders at: id put: newSelf]
