"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testDuplicateReadingPositionable
	self assert: (self with: #(1 3 5 7 9) reading merge: #(2 4 6 8 10) reading sort: [:a :b | a < b]) = #(1 2 3 4 5 6 7 8 9 10).
	self assert: (self with: #(1 2 3 4 5) reading merge: #(6 7 8 9 10) reading sort: [:a :b | a < b])  = #(1 2 3 4 5 6 7 8 9 10).
	self assert: (self with: #(1 2 3 4 10) reading merge: #(5 6 7 8 9) reading sort: [:a :b | a < b])  = #(1 2 3 4 5 6 7 8 9 10).
	self assert: (self with: #(1 2 3 4 5) reading merge: #() reading sort: [:a :b | a < b])  = #(1 2 3 4 5).
	self assert: (self with: #() reading merge: #(6 7 8 9 10) reading sort: [:a :b | a < b]) = #(6 7 8 9 10).
	self assert: (self with: #(1 2 3 4 5) reading merge: #(1 2 3 4 5) reading sort: [:a :b | a < b])  = #(1 1 2 2 3 3 4 4 5 5).