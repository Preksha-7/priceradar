//Import express
const express = require('express');
const router = express.Router();

// Register function
router.post('/register' , (req,res) =>{
    res.status(501).json({error : 'Not implemented yet'});
});

// Login function
router.post('/login', (req,res) =>{
    res.status(501).json({error: 'Not implemented yet'});
});

module.exports = router;