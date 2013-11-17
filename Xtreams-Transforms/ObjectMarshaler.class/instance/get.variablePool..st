"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading variablePool: aClass
	<reads: 'Tools.WorkspaceVariablePool'>

	^aClass new
		imports: (self get: reading string: String);
		instVarNamed: 'bindings' put: (self unmarshal: reading);
		yourself
