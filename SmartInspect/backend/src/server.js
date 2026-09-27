require('dotenv').config();const express=require('express');const cors=require('cors');const path=require('path');
const app=express();app.use(cors({origin:process.env.CLIENT_URL||'http://localhost:5173'}));app.use(express.json());app.use('/uploads',express.static(path.join(__dirname,'../uploads')));
app.get('/',(req,res)=>res.json({name:'SmartInspect API',status:'running'}));
app.use('/api/auth',require('./routes/auth'));app.use('/api/dashboard',require('./routes/dashboard'));app.use('/api/projects',require('./routes/projects'));app.use('/api/inspections',require('./routes/inspections'));app.use('/api/cctv',require('./routes/cctv'));app.use('/api/alerts',require('./routes/alerts'));app.use('/api/evidence',require('./routes/evidence'));
const PORT=process.env.PORT||5000;app.listen(PORT,()=>console.log(`SmartInspect backend running on http://localhost:${PORT}`));
