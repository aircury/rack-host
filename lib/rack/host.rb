require "rack/host/version"

module Rack
  class Host
    def initialize(app, options={})
      @app = app
      @hosts = options[:hosts]
    end

    def call(env)
      request = Rack::Request.new(env)

      puts "############ Host: #{request.host} ############"
      puts @hosts
      puts @hosts.include?(request.host)
      puts "###############################################"

      if @hosts.include?(request.host)
        @app.call(env)
      else
        not_found
      end
    end

    def not_found
      content = 'Not Found'
      [404, {'Content-Type' => 'text/html'}, [content]]
    end
  end
end
