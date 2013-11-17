"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| count amount |
	count := 0.
	[[count = anInteger] whileFalse:
		[amount := cacheSize min: (anInteger - count).
		source read: amount * elementSize into: cache at: 1.
		0 to: amount - 1 do: [:index | aSequenceableCollection at: startIndex + count + index put: (operation value: cache value: index * elementSize + 1)].
		count := count + amount]]
			on: Incomplete do: [:exception |
				0 to: exception count // elementSize - 1 do: [:index | aSequenceableCollection at: startIndex + count + index put: (operation value: cache value: index * elementSize + 1)].
				(Incomplete on: aSequenceableCollection count: count + (exception count / elementSize) at: startIndex) raise].
	^anInteger
