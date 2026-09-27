async function summarizeInspection(text){
  const url=process.env.OLLAMA_URL||'http://localhost:11434';
  const model=process.env.OLLAMA_MODEL||'llama3.2:1b';
  try{
    const r=await fetch(`${url}/api/generate`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({model,prompt:`Summarize this inspection in 5 concise bullets and identify risks:\n${text}`,stream:false})});
    if(!r.ok) throw new Error('Ollama unavailable');
    const d=await r.json(); return d.response || 'No AI response';
  }catch(e){ return null; }
}
module.exports={summarizeInspection};
