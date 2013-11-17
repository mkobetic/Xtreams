"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading variablePool: aClass
	<reads: 'Tools.WorkspaceVariablePool'>

	^aClass new
		imports: (self get: reading string: String);
		instVarNamed: 'bindings' put: (self unmarshal: reading);
		yourself
