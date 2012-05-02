system shutdown
shutDown: quitting 
	"Clean up and unregister all active instances. Do not close the system changes file,
	since this may still be written after calling this method."

	quitting
		ifTrue: [ | changesFile |
				changesFile := SourceFiles at: 2.
				self registry asArray do: [:e |
					changesFile isNil
						ifTrue: [e finalize; unregister]
						ifFalse: [(changesFile ioHandle ~= e) ifTrue: [e finalize; unregister]]]]
