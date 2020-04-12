'use strict';

const express = require('express');
const path = require('path');

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

const htmlDir = path.join(__dirname, 'html');
console.log('htmlDir', htmlDir);

// App
const app = express();
// move static content here
app.use('/', express.static(htmlDir));

// debug dir: http://localhost:1962/api
app.get('/api', (req, res) => {
  res.send('/API works... debugging...');
});

app.listen(PORT, HOST);

console.log(`Express is running on http://${HOST}:${PORT}`);