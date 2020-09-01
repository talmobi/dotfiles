const _envs = {}
Object.keys( process.env ).forEach(
  function ( key ) {
	const n = String( process.env[ key ] ).trim()
	switch ( n ) {
		case '0':
		case 'false':
		case 'undefined':
		case '':
			return _envs[ key ] = false
	}
    _envs[ key ] = process.env[ key ]
  }
)
