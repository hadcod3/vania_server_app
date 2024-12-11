import 'package:vania/vania.dart';
import '../services/database_service.dart';

void productRoutes(Vania app) {
  app.get('/products', (req, res) async {
    final conn = await DatabaseService.getConnection();
    final results = await conn.query('SELECT * FROM products');

    final products = results.map((row) => {
      'prod_id': row['prod_id'],
      'vend_id': row['vend_id'],
      'prod_name': row['prod_name'],  
      'prod_price': row['prod_price'],
      'prod_desc': row['prod_desc'],
    }).toList();

    await conn.close();
    res.json(products);
  });

  app.post('/products', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'INSERT INTO products (prod_id, vend_id, prod_name, prod_price, prod_desc) VALUES (?, ?, ?, ?, ?)',
        [
          data['prod_id'],
          data['vend_id'],
          data['prod_name'],
          data['prod_price'],
          data['prod_desc']
        ]);

    await conn.close();
    res.json({'message': 'Product created'});
  });

  app.put('/products/:id', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'UPDATE products SET vend_id = ?, prod_name = ?, prod_price = ?, prod_desc = ? WHERE prod_id = ?',
        [
          data['vend_id'],
          data['prod_name'],
          data['prod_price'],
          data['prod_desc'],
          id
        ]);

    await conn.close();
    res.json({'message': 'Product updated'});
  });

  app.delete('/products/:id', (req, res) async {
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query('DELETE FROM products WHERE prod_id = ?', [id]);

    await conn.close();
    res.json({'message': 'Product deleted'});
  });
}
