// Import and initialization of important services
require('dotenv').config();
require('./db/connection'); // initialize connection with database
require('./cache/redis'); // initialize connection with redis
const logger = require('./utils/logger'); // inititalize connection with logger
const express = require('express');
const cors = require('cors');
const app = express();
const PORT = process.env.PORT || 5000;

//middleware to allow cross origin requests
app.use(cors({
    origin : function(origin, callback){
        if(!origin) return callback(null, true)
        
        const allowedOrigins = [
            'http://localhost:3000',
            'http://localhost:5000',
             process.env.FRONTEND_URL
        ].filter(Boolean);

        if(allowedOrigins.includes(origin)){
            callback(null, true);
        }
        else{
            callback(null, true);
        }
    },

    credentials : true,
    methods : ['GET' , 'POST' , 'PUT' , 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders : ['Content-Type' , 'Authorization'] 

}));

app.options(/.*/, cors());

//middleware to parse raw data to clean json 
app.use(express.json());
//middleware to parse raw data into clean html form format
app.use(express.urlencoded({extended : true}));

// For health check 
app.get('/health' , (req,res) =>{
    res.json({
        status : 'ok',
        timestamp : new Date().toISOString(),
        service : 'priceradar-api'
    });
});

// Importing all the routes
const authRoutes = require('./routes/auth.routes');
const productRoutes = require('./routes/product.routes');
const alertRoutes = require('./routes/alert.routes');
const analyticsRoutes = require('./routes/analytics.routes');

// Connecting routes to URLs
app.use('/auth' , authRoutes);
app.use('/products' , productRoutes);
app.use('/alerts' , alertRoutes);
app.use('/analytics' , analyticsRoutes);

// For URLs that do not exist
app.use((req, res) => {
    res.status(404).json({error : 'Route not found'});
});

// Global error handles for preventing server crash, providing clean response to the user and easy debugging
// Normal middleware has (req, res, next) , global error handler has (err, req, res, next)
app.use((err, req, res, next) =>{
    console.error(err.stack);
    res.status(err.status || 500).json({
        error : err.message || 'Internal Server Error',
        code : err.status || 500
    });
});

// Starting the server
app.listen(PORT , () => {
    logger.info('PriceRadar API started', { port: PORT });
});

module.exports = app;






