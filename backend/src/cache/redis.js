// Import Redis
const Redis = require('ioredis');

// Creating redis connection
const redis = new Redis(process.env.REDIS_URL, {
    maxRetriesPerRequest : 3,
    retryStrategy(times) {
        return Math.min(times*100 , 3000); // max 3 seconds wait

    },
    tls: {}
});

// starting redis
redis.on('connect' , () => {
    console.log('Redis connected successfully');
});

// Error handling so that it runs without crashing
redis.on('error' , (err) =>{
    console.error('Redis error :' , err.message);
});

module.exports = redis;
