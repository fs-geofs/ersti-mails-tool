let async = require('async'),
  mysql = require('mysql'),
  cfg = require('../config'),
  pool = null;

/**
 * wraps the connection handling
 * @params {String}       query    the SQL query
 * @params {Array|Object} params   Params to supply to the query (?)
 * @params {Function}     callback called with the results
 */
function queryWrapper(query, params, callback) {
  if (!pool) return callback('DB connection not initialized!');

  pool.getConnection(function(err, conn) {
    if (err)
      return callback('could not retrieve DB connection: ', err);

    conn.query(query, params, function(err, result) {
      conn.release();
      callback(err, result);
    });
  });
}

/*
 Creates the Database Connection.
*/
exports.connect = function() {
  pool = mysql.createPool(cfg.mysql);
};

/*
 * Adds a user, if the provided token exists
 * @param {json} data - User Information
 */
exports.insertUser = function(data, callback) {
  var q = 'INSERT users SET ?, year=?;';
  queryWrapper(q, [data, cfg.year], callback)
};

/*
  Gets all user entries for the given year.
  @param {int} year - Year
*/
exports.getUsers = function(year, callback) {
  var q = 'SELECT * FROM users WHERE year=?;';
  queryWrapper(q, [year], callback);
}

/*
  Gets all successors for the given year.
  @param {int} year - Year
*/
exports.getNewsletter = function(year, callback) {
  var q = 'SELECT * FROM users WHERE year=? AND newsletter=1;';
  queryWrapper(q, [year], callback);
}

/*
 * get statistics about the database
 */
exports.getCounts = function(year, callback) {
  const queries = {
    total:     'SELECT COUNT(*) AS count FROM users WHERE year=?;',
    newsletter: 'SELECT COUNT(*) AS count FROM users WHERE year=? AND newsletter=1;',
  };

  async.mapValues(queries, function(query, measure, cb) {
    queryWrapper(query, [year], (err, result) => {
      err ? cb(err) : cb(null, result[0].count);
    });
  }, callback);
}
