"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testMissingClass
	| missingClass missingInstance object |
	missingClass := ObjectMarshaler basicNew
		resolveClass: 'fulluble'
		isMeta: false
		format: (Behavior formatFromType: #none super: Object instVars: #('a' 'b' 'c'))
		instVarNames: #('a' 'b' 'c').
	missingInstance := missingClass new.
	missingInstance instVarNamed: 'a' put: 1.
	missingInstance instVarNamed: 'b' put: 2.
	missingInstance instVarNamed: 'c' put: 3.
	marshaling put: missingInstance.
	self analyse.
	object := marshaling get.
	self assert: object class ~~ missingClass.
	self assert: object class superclass = Object.
	self assert: (object instVarNamed: 'a') = 1.
	self assert: (object instVarNamed: 'b') = 2.
	self assert: (object instVarNamed: 'c') = 3.
	self assert: object a = 1.
	self assert: object b = 2.
	self assert: object c = 3.
	object a: 4.
	object b: 5.
	object c: 6.
	self assert: object a = 4.
	self assert: object b = 5.
	self assert: object c = 6.
