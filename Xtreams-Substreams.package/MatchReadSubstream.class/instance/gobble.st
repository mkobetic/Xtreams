"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
gobble
	| object |
	object := inputBuffer hasDataToRead
		ifTrue: [inputBuffer get]
		ifFalse: [
			[source get] on: Incomplete do: [:incomplete |
				sourceAtEnd := true.
				substreamAtEnd := true.
				^self]].

	(pattern at: candidate) = object
		ifTrue: [
			candidate := candidate + 1.
			candidate > pattern size ifTrue: [
				"full match"
				substreamAtEnd := true.
				inclusive ifTrue: [outputBuffer write: pattern size from: pattern at: 1]]]
		ifFalse: [
			candidate = 1 ifTrue: [
				"no match"
				outputBuffer put: object].
			candidate > 1 ifTrue: [
				| rewind |
				"partial match"
				rewind := backtrack at: candidate.
				outputBuffer write: candidate - rewind from: pattern at: 1.
				inputBuffer put: object.
				candidate := rewind]]