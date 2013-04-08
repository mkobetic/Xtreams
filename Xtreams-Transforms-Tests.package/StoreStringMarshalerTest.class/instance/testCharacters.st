"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testCharacters
	marshaling write: 'testing'.
	self analyse.
	self assert: marshaling rest = #( $t $e $s $t $i $n $g )