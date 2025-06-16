const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Welcome to Kube Shop Frontend!');
});

app.listen(8080, () => {
  console.log('Frontend service running on port 8080');
});

