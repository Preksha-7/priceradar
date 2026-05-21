// Structured JSON logger for easy lookup in logtail

const logger = { // This is a logger object with 3 functions : info, warn, error
    info(message, meta = {} ){
        console.log(JSON.stringify({
            level : 'info',
            message,
            timestamp : new Date().toISOString(),
            service : 'priceradar-backend',
            ...meta
        }));
    },

    warn(message, meta = {}) {
        console.log(JSON.stringify({
            level : 'warn',
            message,
            timestamp : new Date().toISOString(),
            service : 'priceradar-backend',
            ...meta
        }));
    },

    error(message, meta = {}) {
        console.error(JSON.stringify({
            level : 'error',
            message,
            timestamp : new Date().toISOString(),
            service : 'priceradar-backend',
            ...meta
        }));
    }
};

module.exports = logger;