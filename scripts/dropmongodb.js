var dbs = db.getMongo().getDBNames()
for(var i in dbs){
    db = db.getMongo().getDB( dbs[i] );

    var name = db.getName()

    if ( name.indexOf( 'rudolf' ) >= 0 ) {
      print( "dropping db " + name );
      db.dropDatabase();
    }
}
