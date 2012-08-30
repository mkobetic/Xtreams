Implements Hash and HMAC by calling Windows bcrypt (CNG) API. This API is available on Windows Vista and Windows 2008 Server and later versions. Here's a list of available algorithm names (from bcrypt.h): MD2, MD4, MD5, SHA1, SHA256, SHA384, SHA512

Instance Variables
	library	<BCrypt> 
	provider	<CPointer> provider handle
	handle	<CPointer> algorithm handle
	object	<CPointer> algorithm state
	objectLength	<SmallInteger> have to cache the hash object size for #reset
	key	<ByteArray> caches the key (for reset)

