"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: writing - complex
"
put: writing variablePool: aPool
	<writes: 'Tools.WorkspaceVariablePool'>

	self put: writing string: aPool importString.
	self marshal: writing object: aPool localBindings
