"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: analyse - complex
"
analyse: reading variablePool: aClass
	<analyse: 'Tools.WorkspaceVariablePool'>

	reading log: ['variable pool'] do:
		[reading log: 'import' do: [self get: reading string: String].
		reading log: 'bindings' do: [self analyse: reading]].