accessing
finish
	
	| md |
	md := ByteArray new: self digestSize.
	self EVP_DigestFinal_ex: context with: md with: nil.
	^md