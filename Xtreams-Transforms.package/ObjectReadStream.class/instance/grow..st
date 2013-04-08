"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
grow: index
	| replacement |
	(replacement := Array new: index)
		replaceFrom: 1 to: objects size with: objects startingAt: 1.
	objects size + 1 to: index by: 2 do: [:i |
		replacement
			at: i put: false;
			at: i + 1 put: nothing].
	objects := replacement