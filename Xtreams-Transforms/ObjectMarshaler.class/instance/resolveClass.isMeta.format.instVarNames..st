"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
resolveClass: className isMeta: classIsMeta format: classFormat instVarNames: classInstVarNames
	"If a class by the absolute name of className exists, and its shape and format match what was expected, re-use it, otherwise create a shadow-class."

	| class newMetaclass |
	class := className asStrictReference valueOrDo: [nil].
	(class ~~ nil and: [classIsMeta]) ifTrue: [class := class class].

	(class == nil or: [class format ~= classFormat or: [class allInstVarNames asSet ~= classInstVarNames asSet]]) ifTrue: [
		newMetaclass := Metaclass new.
		newMetaclass hash.
		newMetaclass setSuperclass: Object class.
		newMetaclass setInstanceFormat: (classIsMeta ifTrue: [classFormat] ifFalse: [Object class format]).
		newMetaclass instanceVariables: (classIsMeta ifTrue: [(classInstVarNames asSet - Object class instVarNames asSet) asArray] ifFalse: [#()]).
		newMetaclass methodDictionary: Kernel.MethodDictionary new.

		class := newMetaclass new.
		class hash.
		class setName: className.
		class setSuperclass: Object.
		class setInstanceFormat: (classIsMeta ifTrue: [Object format] ifFalse: [classFormat]).
		class instanceVariables: (classIsMeta ifTrue: [#()] ifFalse: [classInstVarNames]).
		class methodDictionary: Kernel.MethodDictionary new.

		classIsMeta ifFalse: [
			classInstVarNames do: [:instVarName |  | methodNode |
				methodNode := class compilerClass new compile: instVarName, ' ^', instVarName in: class notifying: nil ifFail: [].
				class methodDictionary at: methodNode selector put: methodNode generate.
				methodNode := class compilerClass new compile: instVarName, ': anObject ', instVarName, ' := anObject' in: class notifying: nil ifFail: [].
				class methodDictionary at: methodNode selector put: methodNode generate].
			class flushVMmethodCache].
		classIsMeta ifTrue: [class := newMetaclass]].
	^class
