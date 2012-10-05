as yet unclassified
fields
"
	self defineFields
"
	^#(
			(type 'long')
			(pkey_type 'long')
			(md_size 'long')
			(flags 'ulong')
			(init 'void*')
			(update 'void*')
			(final 'void*')
			(copy 'void*')
			(cleanup 'void*')
			(sign 'void*')
			(verify 'void*')
			(required_pkey_type 'long' 20)
			(block_size 'long')
			(ctx_size 'long')
			(md_ctrl 'void*')	
	)