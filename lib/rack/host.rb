require 'ipaddr'
require 'rack/host/version'

module Rack
  class Host
    def initialize(app, options={})
      @app = app
      @hosts = options[:hosts]
    end

    def call(env)
      request = Rack::Request.new(env)

      if is_ip?(request.host)
        if any_ips?(@hosts)
          host     = IPAddr.new(request.host)
          ip_hosts =
            @hosts
              .select {|s| is_ip?(s)}
              .map { |ip| IPAddr.new(ip) }

          if ip_hosts.any? { |ip| ip === host }
            @app.call(env)
          else
            not_found
          end
        else
          not_found
        end
      elsif @hosts.include?(request.host)
        @app.call(env)
      else
        not_found
      end
    end

    def any_ips?(hosts)
      hosts.any? {|s| is_ip?(s)}
    end

    def ip_regex
      /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\/([0-9]|[1-2][0-9]|3[0-2]))?$/
    end

    def is_ip?(str)
      str.is_a?(String) && ip_regex.match?(str)
    end

    def not_found
      content = 'Not Found'
      [404, {'Content-Type' => 'text/html'}, [content]]
    end
  end
end
