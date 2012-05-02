structural
Grammar: definitions
	<action: 'Grammar' arguments: #( 1 )>

	| stream |
	stream := String new writing.
	stream
		tab; write: '| generator definitions |'; cr;
		tab; write: 'definitions := OrderedCollection new.'; cr;
		tab; write: 'generator := PEGParserParser new.'; cr.
	definitions do: [:source | stream tab; write: 'definitions add: '; write: source; write: $.; cr].
	stream tab; write: '^generator Grammar: definitions'.
	^stream contents