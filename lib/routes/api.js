let async = require('async');
let router = require('express').Router();
let db = require('../DBhandler');
let auth = require('../auth');
let validator = require('../inputvalidation');
let cfg = require('../../config');
let csv = require('to-csv');

router.post('/register', validator.registration, function(req, res) {
  const data = validator.escapeHtml(req.body);
  data.newsletter = data.newsletter ? true : false;
  db.insertUser(data, function(err) {
    if (err) return res.status(500).end('Fehler: ' + err);
    res.end('Erfolgreich angemeldet!');
  });
});

// require basic authentication on all following routes
router.use(auth);

// return list of all users, including unused tokens
router.get('/users', (req, res) => dbRequest(req, res, db.getUsers));

// return list of attending users
router.get('/newsletter', (req, res) => dbRequest(req, res, db.getNewsletter));

// return statistics about the database
router.get('/statistics', (req, res) => dbRequest(req, res, db.getCounts));

// wrapper for routes, that only wrap a single db query
function dbRequest(req, res, dbFunction) {
  dbFunction(req.query.year || cfg.year, (err, result) => {
    if (err) return res.status(501).end(err);
    handleResponse(req, res, result);
  });
}

function handleResponse(req, res, data) {
  const format = req.query.format || 'json';
  // add download headers to any response,
  // if the param "download" is present in the query
  if (req.query.download !== undefined) {
    const filename = req.path.slice(1).replace(/\//g, '_') + '.' + format;
    res.append('Content-Disposition', 'attachment; filename=' + filename);
  }

  // convert to csv if format=csv is present in the query
  if (format === 'csv') {
    if (!data.length) data.push({'empty': 'no data'});
    res.append('Content-Type', 'text/csv').send(csv(data));
  } else {
    res.json(data);
  }
}

module.exports = router;
