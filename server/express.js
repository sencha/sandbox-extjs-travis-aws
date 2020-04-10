'use strict';

const express = require('express');
const path = require('path');

// Constants
const PORT = 3000;
const HOST = '0.0.0.0';

const distDir = path.join(__dirname, '..', 'client', 'dist');
console.log('distDir', distDir);

// App
const app = express();
app.use('/', express.static(distDir));

// app.get('/', (req, res) => {
//   res.send('Hello World');
// });

app.listen(PORT, HOST);

console.log(`Running on http://${HOST}:${PORT}`);