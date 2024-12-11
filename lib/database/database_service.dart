import 'package:mysql1/mysql1.dart';

class DatabaseService {
  static Future<MySqlConnection> getConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      db: 'order_entry',
      password: 'password',
    );
    return await MySqlConnection.connect(settings);
  }
}