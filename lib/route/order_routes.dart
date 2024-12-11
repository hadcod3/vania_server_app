void orderRoutes(Vania app) {
  app.get('/orders', (req, res) async {
    final conn = await DatabaseService.getConnection();
    final results = await conn.query('SELECT * FROM orders');

    final orders = results.map((row) => {
      'order_num': row['order_num'],
      'order_date': row['order_date'],
      'cust_id': row['cust_id'],
    }).toList();

    await conn.close();
    res.json(orders);
  });

  app.post('/orders', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'INSERT INTO orders (order_num, order_date, cust_id) VALUES (?, ?, ?)',
        [
          data['order_num'],
          data['order_date'],
          data['cust_id']
        ]);

    await conn.close();
    res.json({'message': 'Order created'});
  });

  app.put('/orders/:id', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'UPDATE orders SET order_date = ?, cust_id = ? WHERE order_num = ?',
        [
          data['order_date'],
          data['cust_id'],
          id
        ]);

    await conn.close();
    res.json({'message': 'Order updated'});
  });

  app.delete('/orders/:id', (req, res) async {
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query('DELETE FROM orders WHERE order_num = ?', [id]);

    await conn.close();
    res.json({'message': 'Order deleted'});
  });
}