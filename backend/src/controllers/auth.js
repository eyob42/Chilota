
const register = (req, res)=> {
    const { password , email , role} = req.body


    res.json({ password , email , role})
}

module.exports = {register};