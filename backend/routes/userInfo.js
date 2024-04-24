const express = require("express")
const router = express.Router()


router.get('/', (req, res) => {
    res.send('this is crazy tyler, when i click the sparkles it sends the message from the backend')
})

module.exports = router