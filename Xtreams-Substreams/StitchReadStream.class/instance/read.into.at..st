"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex
	| remaining amount index |
	index := startIndex.
	remaining := anInteger.
	amount := 0.
	[
		active == nil ifTrue: [
			[active := source get]
				on: Incomplete
				do: [:ex | (Incomplete on: aSequenceableCollection count: anInteger - remaining at: startIndex) raise]].
		amount := [active read: remaining into: aSequenceableCollection at: index] on: Incomplete do: [:ex | ex count].
		remaining := remaining - amount.
		index := index + amount.
		remaining > 0] whileTrue:
			[active close.
			active := nil].
	^anInteger
