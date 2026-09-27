const jwt = require('jsonwebtoken');
require('dotenv').config();

function auth(req,res,next){
  const token = req.headers.authorization?.startsWith('Bearer ') ? req.headers.authorization.slice(7) : null;
  if(!token) return res.status(401).json({message:'Authentication required'});
  try { req.user = jwt.verify(token, process.env.JWT_SECRET); next(); }
  catch { return res.status(401).json({message:'Invalid or expired token'}); }
}
function roles(...allowed){ return (req,res,next)=> allowed.includes(req.user.role) ? next() : res.status(403).json({message:'Insufficient permissions'}); }
module.exports={auth,roles};
