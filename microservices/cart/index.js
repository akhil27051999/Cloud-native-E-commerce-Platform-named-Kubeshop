const express = require('express');
const app = express();

app.get('/cart', (req, res) => {
  res.json({ cart: ['item1', 'item2'] });
});

app.get('/', (req, res) => {
  res.send('Cart Service Running');
});

app.listen(3000, () => {
  console.log('Cart service listening on port 3000');
});

