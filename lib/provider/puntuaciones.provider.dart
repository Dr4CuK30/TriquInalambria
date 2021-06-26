import 'package:mongo_dart/mongo_dart.dart';
import 'package:triqui_inalambria/database/DBConnection.dart';

class PuntuacionesProvider {
  DBConnection dbc;

  PuntuacionesProvider() {
    dbc = DBConnection.getInstance();
  }

  getPuntuaciones() async {
    DbCollection puntuaciones = await _dbGetColl();
    return await puntuaciones.find(where.sortBy("puntuacion", descending: true).limit(10)).toList();
  }

  submitPuntuacion(String usuario, int puntuacion) async {
    DbCollection puntuaciones = await _dbGetColl();
    final registro = await puntuaciones.findOne({"usuario": usuario});
    if (registro != null) {
      if (puntuacion > registro['puntuacion']) {
        puntuaciones.updateOne(
            where.eq("usuario", usuario), modify.set("puntuacion", puntuacion));
        return;
      } else {
        return;
      }
    } else {
      puntuaciones.insert({"usuario": usuario, "puntuacion": puntuacion});
    }
    return;
  }

  Future<DbCollection> _dbGetColl() async{
    Db db = await dbc.getConnection();
    return db.collection("puntuaciones");
  }
}
