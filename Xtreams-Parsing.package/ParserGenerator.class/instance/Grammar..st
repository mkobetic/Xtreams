"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: structural
"
Grammar: definitions
	<action: 'Grammar' arguments: #( 1 )>

	| stream |
	stream := String new writing.
	stream
		tab; write: '| generator definitions |'; cr;
		tab; write: 'definitions := OrderedCollection new.'; cr;
		tab; write: 'generator := PEG.ParserParser new.'; cr.
	definitions do: [:source | stream tab; write: 'definitions add: '; write: source; write: $.; cr].
	stream tab; write: '^generator Grammar: definitions'.
	^stream contents