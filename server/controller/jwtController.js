export default function buildJwtController(jwt,secret){
    
     function verify(token){
            return new Promise((resolve, reject)=>{
                jwt.verify(token,secret,(err,decoded)=>{
                    if(!err){
                        if(decoded){
                            return resolve(decoded);
                        }
                    }

                    return reject(err);
                });
            });
        }

        function sign(user){
            return new Promise((resolve, reject)=>{
                jwt.sign(user,secret,(err,token)=>{
                    if(!err){
                        if(token){
                            return resolve(token);
                        }
                    }

                    return reject(err);
                });
            });
        }

  
        return Object.freeze({
           verify:(token)=>verify(token),
           sign:(user)=>sign(user.username),
        });

    
}