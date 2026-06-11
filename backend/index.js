console.log('server starting...')
require('dotenv').config();
const express = require('express');
const app = express();
const authRouter  = require('./src/routes/auth');
require('./db');


const PORT = process.env.PORT || 3000;

app.use(express.json());

app.use('/api/auth', authRouter);

app.get('/',(req, res)=> {
    res.send('Chilota API is running!');
});

app.listen(PORT, () => {
    console.log(`app listening  on port ${PORT}`);
});