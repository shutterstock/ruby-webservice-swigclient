class WebServiceSwigClient
  VERSION = '0.0.1'
  require 'curly'

  def initialize(params)
    @api_key       = params[:api_key]
    @service_url   = params[:service_url]
    @error_handler = params[:error_handler]
  end

  def render(path, data)
    url = [@service_url, @api_key, path].join("/");
    response = Curly::Request.post(url, headers: { 'Content-type' => 'application/json' }, body: data.to_json)

    if ( !response.success? )
      if ( @error_handler )
        @error_handler.call("There was a problem communicating with the server", response)
      end
      return
    else
      return response.body
    end
  end
end

