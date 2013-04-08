"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
log: type do: aBlock
	| superlog sublog position incomplete |
	position := source position.
	superlog := log.
	log := String new writing.

	depth := depth + 1.
	incomplete := false.
	^[aBlock on: Incomplete do: [:ex | incomplete := true. ex pass]] ensure:
		[depth := depth - 1.
		sublog := log conclusion.
		log := superlog.

		incomplete ifFalse:
			[log tab: depth; print: position; write: '+'; print: (source position - position); tab.
			type isCharacters
				ifTrue:	[log write: type]
				ifFalse:	[log write: type value].
			log cr; write: sublog]]