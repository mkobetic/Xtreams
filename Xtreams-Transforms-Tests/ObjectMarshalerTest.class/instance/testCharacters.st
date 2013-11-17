"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testCharacters
	marshaling write: 'testing'.
	self analyse.
	self assert: marshaling rest = #( $t $e $s $t $i $n $g )
