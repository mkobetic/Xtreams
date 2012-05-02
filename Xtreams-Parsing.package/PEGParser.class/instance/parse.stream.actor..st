parsing
parse: definition stream: aStream actor: anActor
	"Parse @definition from aStream using @anActor to act on the matching rules.
	""	definition	<String>			identifies the rule of the grammar to apply to the input
		aStream		<ReadStream>	the input to parse
		anActor		<Actor>			receives callbacks from the parser for the successfully rules with the matching the input
		^			<Object>		result of the actor action for the @definition
	"
	| object |
	actor := anActor.
	stream := aStream reading.
	self clear.
	object := (grammar at: definition) value.
	^object == Failure
		ifTrue:	[nil]
		ifFalse:	[object]