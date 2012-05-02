lexical
Escape: backslash character: character hexes: hexes
	<action: 'Escape' arguments: #( 1 2 3 )>

	backslash = '\' ifTrue:
		[character = $s ifTrue: [^Character space].
		character = $t ifTrue: [^Character tab].
		character = $n ifTrue: [^Character cr].
		character = $r ifTrue: [^Character lf].
		character = $x ifTrue: [^('16r', (String withAll: hexes)) asNumber asCharacter]].
	^character