const express = require('express');
const router = express.Router();
const {register} = require('../controllers/auth.js')

// register route will go here

router.post('/register', register)


module.exports = router;