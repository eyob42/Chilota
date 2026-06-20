const pool = require('../../db');
const register =async (req, res)=> {
    const { password , email , role} = req.body

    const checkEmailQuery = 'SELECT id FROM users WHERE email = $1;';
    const result = await pool.query(checkEmailQuery, [email]);

    if(result.rows.length > 0 ) {
        return res.status(400).json({
            error: 'Email already exists'
        });
    }

    res.status(200).json({
        message: 'Email is available'
    })

    res.json({ password , email , role})
}

module.exports = {register};