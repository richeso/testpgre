
var db = require('./queries');
var errfn  = function(err) {
	console.log("Error encountered: "+err);
};
module.exports = {
  configure: function(app) {
    app.get('/api/puppies', function(req, res) {
    	db.getAll(req,res, errfn);
    });

    app.get('/api/puppies/:id', function(req, res) {
      db.getPuppy(req, res, errfn);
    });
    
    app.put('/api/puppies', function(req, res) {
      db.createPuppy(req, res, errfn);
    });

    app.put('/api/puppies/:id', function(req, res) {
      db.updatePuppy(req, res, errfn);
    });
    app.delete('/api/puppies/:id', function(req, res) {
      db.deletePuppy(req, res, errfn);
    });
  }
};
