*Xtreams-TransformsTests-encoding
testReadDecodingUTF8

	| result bytes text |
	text := 'Příliš žluťoučký kůň úpěl ďábelské ódy'.
	bytes := #[80 197 153 195 173 108 105 197 161 32 197 190 108 117 197 165 111 117 196 141 107 195 189 32 107 197 175 197 136 32 195 186 112 196 155 108 32 196 143 195 161 98 101 108 115 107 195 169 32 195 179 100 121].
	self output write: bytes; close.
	result := (self input encoding: #utf8) read: text size.
	self assert: result = text