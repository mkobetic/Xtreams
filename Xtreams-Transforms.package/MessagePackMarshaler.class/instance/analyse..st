"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
analyse: reading
	| type |
	type := reading uint8 get.
	type <= 16rBF ifTrue: [
		| fixMapOrArray |
		type <= 16r7F ifTrue: [^reading log: 'positive fixnum' do: [type]].
		fixMapOrArray := type bitShift: -4.
		fixMapOrArray = 2r1001 ifTrue: [^reading log: 'fix array' do: [(1 to: (type bitAnd: 2r00001111)) collect: [:i | self analyse: reading]]].
		fixMapOrArray = 2r1000 ifTrue: [
			^reading log: 'fix map' do: [
				| map |
				map := Dictionary new.
				(type bitAnd: 2r00001111) timesRepeat: [
					map at: (self analyse: reading) put: (self analyse: reading)].
				map]].
		^reading log: 'fix raw' do: [reading uint8 read: (type bitAnd: 2r00011111)]].
	(type bitShift: -5) = 2r111 ifTrue: [^reading log: 'negative fixnum' do: [-32 + (type bitAnd: 2r00011111)]].
	^reading log: (type printStringRadix: 16) do: [(analysing at: type) value: reading]