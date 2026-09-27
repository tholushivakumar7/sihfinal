const router=require('express').Router();const db=require('../config/db');const {auth}=require('../middleware/auth');
router.get('/',auth,async(req,res)=>{try{const [rows]=await db.query(`SELECT a.*,p.project_name FROM alerts a LEFT JOIN projects p ON p.id=a.project_id ORDER BY a.created_at DESC`);res.json(rows)}catch(e){res.status(500).json({message:e.message})}});
router.put('/:id/resolve',auth,async(req,res)=>{await db.execute("UPDATE alerts SET status='RESOLVED' WHERE id=?",[req.params.id]);res.json({message:'Alert resolved'})});module.exports=router;
