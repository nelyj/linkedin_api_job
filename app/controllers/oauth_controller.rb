class OauthController < ApplicationController
  #PASO 3: Recibo el código "code" de linkedin y lo guardo en una variable
  def callback
    opts = {
      grant_type: 'authorization_code',
      code: params[:code],
      redirect_uri: 'http://localhost:3000/oauth/callback',
      client_id: '78avq2aog6a9iz',
      client_secret: 'W8NeNHaIBgBqy4yc'
    }

    #PASO 4 Envío un POST a la url access_token con los parámetros de la variable opts
    res = Faraday.post('https://www.linkedin.com/oauth/v2/accessToken') do |req|
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = URI.encode_www_form(opts) #NOTA el URI.encode_www_form(opts) deja los parámetros en un formato encode válido osea grant_type=authorization_code&code=elcodigorecibido&redirect_uri=.......
    end

    #PASO 4.1 utilizo la variable res y hago un parse de los datos para obtener el access token
    access_token = JSON.parse(res.body)['access_token']

    #PASO 4.2 guardo el access_token en la base de datos. Tienen que tener claro que este access token es el que usaran para hacer llamadas a otros endpoint de una api
    Authorization.create(access_token: access_token)

    redirect_to root_path
  end

  #PASO 1: Genero link para ir a la página de redirección de linkedin
  def authorization
    opts = {
      response_type: 'code',
      client_id: '78avq2aog6a9iz',
      redirect_uri: 'http://localhost:3000/oauth/callback',
      state: 'jobFooBar',
      scope: 'r_liteprofile r_emailaddress w_member_social'
    }
    uri_encode = URI.encode_www_form(opts)
    url = 'https://www.linkedin.com/oauth/v2/authorization?' + uri_encode

    redirect_to url
  end
end
