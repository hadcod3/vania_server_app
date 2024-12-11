import 'package:vania/vania.dart';
import '../services/database_service.dart';

void customerRoutes(Vania app) {
  app.get('/customers', (req, res) async {
    final conn = await DatabaseService.getConnection();
    final results = await conn.query('SELECT * FROM customers');

    final customers = results.map((row) => {
      'cust_id': row['cust_id'],
      'cust_name': row['cust_name'],
      'cust_address': row['cust_address'],
      'cust_city': row['cust_city'],
      'cust_state': row['cust_state'],
      'cust_zip': row['cust_zip'],
      'cust_country': row['cust_country'],
      'cust_telp': row['cust_telp'],
    }).toList();

    await conn.close();
    res.json(customers);
  });

  app.post('/customers', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'INSERT INTO customers (cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_telp) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          data['cust_id'],
          data['cust_name'],
          data['cust_address'],
          data['cust_city'],
          data['cust_state'],
          data['cust_zip'],
          data['cust_country'],
          data['cust_telp']
        ]);

    await conn.close();
    res.json({'message': 'Customer created'});
  });

  app.put('/customers/:id', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'UPDATE customers SET cust_name = ?, cust_address = ?, cust_city = ?, cust_state = ?, cust_zip = ?, cust_country = ?, cust_telp = ? WHERE cust_id = ?',
        [
          data['cust_name'],
          data['cust_address'],
          data['cust_city'],
          data['cust_state'],
          data['cust_zip'],
          data['cust_country'],
          data['cust_telp'],
          id
        ]);

    await conn.close();
    res.json({'message': 'Customer updated'});
  });

  app.delete('/customers/:id', (req, res) async {
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query('DELETE FROM customers WHERE cust_id = ?', [id]);

    await conn.close();
    res.json({'message': 'Customer deleted'});
  });
}