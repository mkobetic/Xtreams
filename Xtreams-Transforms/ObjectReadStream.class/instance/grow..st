"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
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
