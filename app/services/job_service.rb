require 'faraday'
class JobService
  def self.me
    new.me
  end

  def me
    #PASO 5: obtengo el último access_token. Generalmente se guarda el token por usuario creado.
    #esto quiere decir que para su caso quizás es bueno asignarlo a un usuario en el PASO 4
    access_token = Authorization.last.access_token

    #PASO 6: Hago una llamada a un endpoint, en este caso para obtener los datos personas de la cuenta a la que pertenece los access token
    res = Faraday.get('https://api.linkedin.com/v2/me') do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
      req.headers['cache-control'] = 'no-cache'
      req.headers['X-Restli-Protocol-Version'] = '2.0.0'
    end
    
    #PASO 7: Parseo los datos para devolver un hash con los datos. En el caso de frameworks frontend como Vue.js y React.js podrías usar el hash y mostrar los datos fácilmente.
  
    #EN otros lenguajes puedes podrías usar el hash directo en html o podrías guardar ésta información en una base de datos para mostrarlo posteriormente.
    
    #Yo mostraré el hash en la vista directamente.
    JSON.parse(res.body)
  end
end
