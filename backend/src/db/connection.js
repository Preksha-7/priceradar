// Importing mysql 
const mysql = require('mysql2/promise');

// Read pool for SELECT quereis : more connections since read are more frequent than writes
const readPool = mysql.createPool({
    host : process.env.TIDB_HOST,
    port : parseInt(process.env.TIDB_PORT) || 4000,
    user : process.env.TIDB_USER,
    password : process.env.TIDB_PASSWORD,
    database : process.env.TIDB_DATABASE,
    ssl : { rejectUnauthorized : false },
    connectionLimit : 7,
    waitForConnections : true,
    queueLimit : 0,
    timezone :'Z'
});

// Write pool for INSERT, UPDATE, DELETE etc : fewer connections are required
const writePool = mysql.createPool({
    host : process.env.TIDB_HOST,
    port : parseInt(process.env.TIDB_PORT) || 4000,
    user : process.env.TIDB_USER,
    password : process.env.TIDB_PASSWORD,
    database : process.env.TIDB_DATABASE,
    ssl : { rejectUnauthorized : false},
    connectionLimit : 3,
    waitForConnections : true,
    queueLimit : 0,
    timezone :'Z'
});

// To check if the connection is possible 
async function testConnection() {
    try{
    const readConn = await readPool.getConnection();
    const writeConn = await writePool.getConnection();

    await readConn.query('SELECT 1');
    await writeConn.query('SELECT 1');

    readConn.release();
    writeConn.release();

    console.log('TiDB connected successfully (read + write pools)');
    }

    catch(err) {
        console.error('TiDB connection failed' , err.message);
        process.exit(1); // crash on start if database is not reachable
    }
}

testConnection();

module.exports = {readPool, writePool};