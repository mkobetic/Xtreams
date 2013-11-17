"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: writing - complex
"
put: writing variablePool: aPool
	<writes: 'Tools.WorkspaceVariablePool'>

	self put: writing string: aPool importString.
	self marshal: writing object: aPool localBindings
