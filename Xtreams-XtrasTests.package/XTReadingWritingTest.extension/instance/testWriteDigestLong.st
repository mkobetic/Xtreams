*Xtreams-XtrasTests-crypto
testWriteDigestLong

	| content result out hash |
	content := ByteArray new: 32769.
	1 to: content size do: [:index | content at: index put: index \\ 256].
	hash := #[202 69 13 60 129 209 112 134 7 155 163 187 244 181 192 223 248 50 178 245].

	self timeout: 1000 milliseconds
		server:	[
			out := self output hashing: 'SHA1'.
			[ out write: content ] ensure: [ out close ].
			out digest = hash]
		client:	[
			result := self input read: content size.
			result = content]