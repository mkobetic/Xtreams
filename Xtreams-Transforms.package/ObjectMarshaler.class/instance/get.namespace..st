"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: reading - complex
"
get: reading namespace: aClass
	<reads: 'Kernel.NameSpace'>

	^(self get: reading string: String) asStrictReference value
