void vendorRoutes(Vania app) {
  app.get('/vendors', (req, res) async {
    final conn = await DatabaseService.getConnection();
    final results = await conn.query('SELECT * FROM vendors');

    final vendors = results.map((row) => {
      'vend_id': row['vend_id'],
      'vend_name': row['vend_name'],
      'vend_address': row['vend_address'],
      'vend_kota': row['vend_kota'],
      'vend_state': row['vend_state'],
      'vend_zip': row['vend_zip'],
      'vend_country': row['vend_country'],
    }).toList();

    await conn.close();
    res.json(vendors);
  });

  app.post('/vendors', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'INSERT INTO vendors (vend_id, vend_name, vend_address, vend_kota, vend_state, vend_zip, vend_country) VALUES (?, ?, ?, ?, ?, ?, ?)',
        [
          data['vend_id'],
          data['vend_name'],
          data['vend_address'],
          data['vend_kota'],
          data['vend_state'],
          data['vend_zip'],
          data['vend_country']
        ]);

    await conn.close();
    res.json({'message': 'Vendor created'});
  });

  app.put('/vendors/:id', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'UPDATE vendors SET vend_name = ?, vend_address = ?, vend_kota = ?, vend_state = ?, vend_zip = ?, vend_country = ? WHERE vend_id = ?',
        [
          data['vend_name'],
          data['vend_address'],
          data['vend_kota'],
          data['vend_state'],
          data['vend_zip'],
          data['vend_country'],
          id
        ]);

    await conn.close();
    res.json({'message': 'Vendor updated'});
  });

  app.delete('/vendors/:id', (req, res) async {
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query('DELETE FROM vendors WHERE vend_id = ?', [id]);

    await conn.close();
    res.json({'message': 'Vendor deleted'});
  });
}