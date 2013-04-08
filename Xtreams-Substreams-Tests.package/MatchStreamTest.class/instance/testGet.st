"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testGet

	| stream |
	stream := '1-2--345' reading ending: '--'.
	'1-2' do: [ :c | self assert: stream get = c ].
	self should: [ stream get ] raise: Incomplete