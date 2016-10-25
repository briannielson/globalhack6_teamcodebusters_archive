var express = require('express');
var router = express.Router();
var mysql = require('mysql');
var connection = mysql.createConnection({
  host: 'codebusters.cfolwbsu62ee.us-west-2.rds.amazonaws.com',
  user: 'codebusters',
  password: 'correcthorsebatterystaple',
  database: 'codebusters'
});
connection.connect();

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});


router.get('/shelter/status.json', function(req, res, next) {
  connection.query('SELECT shelter_check_in.shelter_id, beds.bed_types, COUNT(shelter_check_in.id) as taken, beds.total FROM shelter_check_in LEFT JOIN beds ON shelter_check_in.shelter_id=beds.shelter_id WHERE in_timestamp IS NOT NULL AND out_timestamp IS NULL Group By beds.bed_types', function(err, inResults) {
    connection.query('SELECT shelter_check_in.shelter_id, beds.bed_types, COUNT(shelter_check_in.id) as available, beds.total FROM shelter_check_in LEFT JOIN beds ON shelter_check_in.shelter_id=beds.shelter_id WHERE in_timestamp IS NULL AND out_timestamp IS NOT NULL GROUP BY beds.bed_types',function(err, outResults) {
      console.log(JSON.stringify(inResults));
      console.log('===');
      console.log(JSON.stringify(outResults));
      resultDict = {};
      for (var result of inResults) {
        result.available = result.total - result.taken;
        delete result.taken;
        resultDict[result.shelter_id] = result;
      }
      for (var result of outResults) {
        if (isset(resultDict[result.shelter_id])) {
          resultDict[result.shelter_id].available += result.available;
        } else {
          resultDict[result.shelter_id] = result;
        }
      }

      console.log('===');
      console.log(JSON.stringify(resultDict));

      var results = [];
      for (var key in resultDict) {
        results.push(resultDict[key]);
      }
      res.json({beds: results});
    });
  });
});



router.get('/shelter/:id', function(req, res, next) {
  var data = {
    id: req.params.id
  };

  connection.query('SELECT id, name, street, city, state, zip, phone, website, open, close, auto_check_out from shelters where ?', data, function(err, result) {
    if (err)
      res.error(err);
    else
      res.render('./shelter/index', {shelter: result[0], layout: './shelter/layout'});
  });
});

router.get('/check/interface', function(req, res, next) {
  connection.query('SELECT id,name from homeless_types', function(err, results) {
    if (err)
      res.error(err);
    else
      res.render('./checkin/index', {homeless_types: results, layout: './checkin/layout'});
  });
});

router.get('/shelter.json', function(req, res, next) {
  if (req.query.id != null) {  
    var data = {
      id: req.query.id
    };
    
    connection.query('SELECT id, name, street, city, state, zip, phone, website, open, close, auto_check_out from shelters where ?', data, function(err, result) {
      if (err)
        res.json({error: err.message});
      else
        res.json({shelter: result[0]});
      });
  }
});

router.get('/shelters.json', function(req, res, next) {
  connection.query('Select id, name, street, city, state, zip, phone, website, open, close, auto_check_out from shelters', function(err, results) {
      if (err)
        res.json({error: err.message});
      else
        res.json({shelters: results});
  });
});

router.get('/user/add', function(req, res, next) {
  var data = {
    type: req.query.type,
    size: req.query.size
  };

  connection.query('Insert into homeless set ?', data, function(err, result) {
    if (err)
      res.json({error: err.message});
    else {
      connection.query('Update homeless set uuid=? where id=?', [result.insertId, result.insertId], function(err) {
        if (err)
          console.log(err.message);
        res.json({uuid: result.insertId});
      });
    }
  });
});

router.get('/user/get', function(req, res, next) {
  var data = {
    uuid: req.query.uuid
  };

  connection.query('Select uuid,type,size From homeless where ?', data, function(err, results) {
    if (err)
      res.json({error: err.message});
    else {
      res.json({user: results});
    }
  });
});

router.get('/checkin', function(req, res, next) {
  var data = {
    uuid: req.query.uuid,
    type: req.query.type,
    size: req.query.size
  };

  connection.query('Select * from homeless where ?', {uuid: data.uuid}, function(err, results) {
    if (err)
      res.json({error: err.message, success: false});
    else {
      var dankness = function(homeless_id) {
        var insertData = {
          homeless_id: homeless_id,
          shelter_id: 1
        }
        connection.query('Insert into shelter_check_in set ?', insertData, function(err,result) {
          if (err)
            res.json({error: err.message, success: false});
          else {
            res.json({success: true});
          }
        });
      };
      latest = results[results.length - 1];
      if (data.type != latest.type || data.size != latest.size) {
        connection.query('Insert into homeless set ?', data, function(err,result) {
          if (err)
            res.json({error: err.message, success: false});
          else {
            dankness(result.insertId);
          }
        });
      } else {
        dankness(latest.id);
      }
    }
  });

  
});

module.exports = router;
