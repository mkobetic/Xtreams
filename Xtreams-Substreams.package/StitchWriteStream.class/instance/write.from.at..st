"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
write: anInteger from: aSequenceableCollection at: startIndex
	| remaining amount index |
	index := startIndex.
	remaining := anInteger.
	amount := 0.
	[
		active == nil ifTrue: [
			[active := destination get]
				on: Incomplete
				do: [ :ex | (Incomplete on: aSequenceableCollection count: anInteger - remaining at: startIndex) raise]].
		amount := [active write: remaining from: aSequenceableCollection at: index] on: Incomplete do: [:ex | ex count].
		remaining := remaining - amount.
		index := index + amount.
		remaining > 0] whileTrue:
			[active close.
			active := nil].
	^anInteger
