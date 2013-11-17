"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testCharacters
	marshaling write: 'testing'.
	self analyse.
	self assert: marshaling rest = #( $t $e $s $t $i $n $g )
