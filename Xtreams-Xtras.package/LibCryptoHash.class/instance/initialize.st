initialize-release
initialize
	
	context := XTEVPMDCTX externalNew.
	self EVP_MD_CTX_init: context