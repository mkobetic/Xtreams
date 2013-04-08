"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: actions
"
putAssociation: anAssociation
	<action: #{Core.Association}>

	self putObjectWith: [ :emitKeyValue |
		emitKeyValue value: anAssociation key asString value: anAssociation value ]