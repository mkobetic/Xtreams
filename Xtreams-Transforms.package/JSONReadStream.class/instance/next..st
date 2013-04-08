"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
next: count

	^next
		ifNil: [ source read: count ]
		ifNotNil: [ | out |
			out := (String new: count) writing.
			out put: self next.
			out write: count - 1 from: source.
			out close; terminal ]