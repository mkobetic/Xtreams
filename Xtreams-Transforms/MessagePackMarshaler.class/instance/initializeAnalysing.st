"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
initializeAnalysing
	(analysing := unmarshaling copy)
		at: self class array16 put: [:reading | reading log: 'array16' do: [(1 to: reading uint16 get) collect: [:i | self analyse: reading]]];
		at: self class array32 put: [:reading | reading log: 'array32' do: [(1 to: reading uint32 get) collect: [:i | self analyse: reading]]];
		at: self class map16 put: [:reading |
			reading log: 'map16' do: [
				| map |
				map := Dictionary new.
				reading uint16 get timesRepeat: [
					map at: (self analyse: reading) put: (self analyse:reading)].
				map]];
		at: self class map32 put: [:reading |
			reading log: 'map32' do: [
				| map |
				map := Dictionary new.
				reading uint16 get timesRepeat: [
					map at: (self analyse: reading) put: (self analyse: reading)].
				map]];
		yourself
