async function notifyN8n(payload){
  const url=process.env.N8N_WEBHOOK_URL;
  if(!url) return {sent:false};
  try{
    const r=await fetch(url,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(payload)});
    return {sent:r.ok};
  }catch{return {sent:false};}
}
module.exports={notifyN8n};
