// Import express
const express = require('express');
const router = express.Router();


router.get('/', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));
router.get('/unread', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));
router.patch('/:id/read',(req, res) => res.status(501).json({ error: 'Not implemented yet' }));
router.patch('/read-all', (req, res) => res.status(501).json({ error: 'Not implemented yet' }));

module.exports = router;