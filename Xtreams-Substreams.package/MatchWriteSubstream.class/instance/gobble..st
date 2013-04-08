"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
gobble: object

	(pattern at: candidate) = object
		ifTrue: [
			candidate := candidate + 1.
			candidate > pattern size ifTrue: [
				"full match"
				substreamAtEnd := true.
				inclusive ifTrue: [
					destination write: pattern size from: pattern at: 1.
					^pattern size].
				].
			^0]
		ifFalse: [
			candidate = 1 ifTrue: [
				"no match"
				destination put: object.
				^1].
			candidate > 1 ifTrue: [
				| rewind amount |
				"partial match"
				rewind := backtrack at: candidate.
				amount := candidate - rewind.
				destination write: amount from: pattern at: 1.
				candidate := rewind.
				^amount + (self gobble: object)]]