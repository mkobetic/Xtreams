class initialization
initialize

	DialectEncoder := self.
	TextConverterMap := IdentityDictionary new.
	TextConverter withAllSubclassesDo: [:converterClass |
		converterClass encodingNames do: [: encodingName |
			TextConverterMap at: encodingName asSymbol put: converterClass]].