void productNotesRoutes(Vania app) {
  app.get('/productnotes', (req, res) async {
    final conn = await DatabaseService.getConnection();
    final results = await conn.query('SELECT * FROM productnotes');

    final productNotes = results.map((row) => {
      'note_id': row['note_id'],
      'prod_id': row['prod_id'],
      'note_date': row['note_date'],
      'note_text': row['note_text'],
    }).toList();

    await conn.close();
    res.json(productNotes);
  });

  app.post('/productnotes', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'INSERT INTO productnotes (note_id, prod_id, note_date, note_text) VALUES (?, ?, ?, ?)',
        [
          data['note_id'],
          data['prod_id'],
          data['note_date'],
          data['note_text']
        ]);

    await conn.close();
    res.json({'message': 'Product note created'});
  });

  app.put('/productnotes/:id', (req, res) async {
    final data = await req.bodyAsJsonMap;
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query(
        'UPDATE productnotes SET prod_id = ?, note_date = ?, note_text = ? WHERE note_id = ?',
        [
          data['prod_id'],
          data['note_date'],
          data['note_text'],
          id
        ]);

    await conn.close();
    res.json({'message': 'Product note updated'});
  });

  app.delete('/productnotes/:id', (req, res) async {
    final id = req.params['id'];
    final conn = await DatabaseService.getConnection();
    await conn.query('DELETE FROM productnotes WHERE note_id = ?', [id]);

    await conn.close();
    res.json({'message': 'Product note deleted'});
  });
}
