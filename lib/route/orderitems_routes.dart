void orderItemsRoutes(Vania app) {
  app.get('/orderitems', (req, res) async {
    final conn = await DatabaseService.getConnection();
    final results = await conn.query('SELECT * FROM orderitems');

    final orderItems = results.map((row) => {
      'order_item': row['order_item'],
      'order_num': row['order_num'],
      'prod_id': row['prod_id'],
      'quantity': row['quantity'],
      'size': row['size'],
    }).toList();

    await conn.close();
    res.json(orderItems);
  });

  app.post('/orderitems', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'INSERT INTO orderitems (order_item, order_num, prod_id, quantity, size) VALUES (?, ?, ?, ?, ?)',
        [
          data['order_item'],
          data['order_num'],
          data['prod_id'],
          data['quantity'],
          data['size']
        ]);

    await conn.close();
    res.json({'message': 'Order item created'});
  });

  app.put('/orderitems/:id', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'UPDATE orderitems SET order_num = ?, prod_id = ?, quantity = ?, size = ? WHERE order_item = ?',
        [
          data['order_num'],
          data['prod_id'],
          data['quantity'],
          data['size'],
          id
        ]);

    await conn.close();
    res.json({'message': 'Order item updated'});
  });

  app.delete('/orderitems/:id', (req, res) async {
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query('DELETE FROM orderitems WHERE order_item = ?', [id]);

    await conn.close();
    res.json({'message': 'Order item deleted'});
  });
}