// Import express
const express = require('express');
const router = express.Router();

// search function
router.get('/search', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));

//track function
router.post('/track', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));

// tracked function
router.get('/tracked', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));

//id function
router.get('/:id', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));

//id history function
router.get('/:id/history', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));

// delete function
router.delete('/:id/untrack',(req, res) => res.status(501).json({ error: 'Not implemented yet' }));

module.exports = router;