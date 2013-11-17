"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: class initialization
"
initialize
	| newSelf |
	newSelf := self new.
	#(#'latin-1' #latin1 #iso8859L1 #ISO8859L1) do: [:id | self encoders at: id put: newSelf]
