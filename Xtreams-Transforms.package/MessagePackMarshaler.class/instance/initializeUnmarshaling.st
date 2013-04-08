"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initializeUnmarshaling
	(unmarshaling := Array new: 255 withAll: [:reading | self error: 'unknown type'])
		"singletons"
		at: self class nil put: [:reading | nil];
		at: self class true put: [:reading | true];
		at: self class false put: [:reading | false];

		"numbers"
		at: self class uint8 put: [:reading | reading uint8 get];
		at: self class uint16 put: [:reading | reading uint16 get];
		at: self class uint32 put: [:reading | reading uint32 get];
		at: self class uint64 put: [:reading | reading uint64 get];
		at: self class int8 put: [:reading | reading int8 get];
		at: self class int16 put: [:reading | reading int16 get];
		at: self class int32 put: [:reading | reading int32 get];
		at: self class int64 put: [:reading | reading int64 get];
		at: self class float put: [:reading | reading float get];
		at: self class double put: [:reading | reading double get];

		"containers"
		at: self class raw16 put: [:reading | reading uint8 read: reading uint16 get];
		at: self class raw32 put: [:reading | reading uint8 read: reading uint32 get];
		at: self class array16 put: [:reading | (1 to: reading uint16 get) collect: [:i | self unmarshal: reading]];
		at: self class array32 put: [:reading | (1 to: reading uint32 get) collect: [:i | self unmarshal: reading]];
		at: self class map16 put: [:reading |
			| size map |
			size := reading uint16 get.
			map := Dictionary new: size.
			size timesRepeat: [
				map noCheckAdd: (self unmarshal: reading) -> (self unmarshal: reading)].
			map];
		at: self class map32 put: [:reading |
			| size map |
			size := reading uint32 get.
			map := Dictionary new: size.
			size timesRepeat: [
				map noCheckAdd: (self unmarshal: reading) -> (self unmarshal: reading)].
			map];
		yourself