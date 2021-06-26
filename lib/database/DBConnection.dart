import 'package:mongo_dart/mongo_dart.dart' show Db, DbCollection;
class DBConnection{

  static DBConnection _instance;

  final String _host = "root";
  final String _port = "root@cluster0.l7diy.mongodb.net";
  final String _dbName = "triqui";
  Db _db;

  static getInstance(){
    if(_instance == null) {
      _instance = DBConnection();
    }
    return _instance;
  }

  Future<Db> getConnection() async{
    if (_db == null){
      try {
        _db = await Db.create(_getConnectionString());
        await _db.open();
      } catch(e){
        print(e);
      }
    }
    return _db;
  }

  _getConnectionString(){
    return "mongodb+srv://$_host:$_port/$_dbName?retryWrites=true&w=majority";
  }

  closeConnection() {
    _db.close();
  }

}