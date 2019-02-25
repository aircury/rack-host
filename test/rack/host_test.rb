require 'test_helper'

class Rack::HostTest < Minitest::Test
  include Rack::Test::Methods

  def backend
    lambda { |env| [200, {'Content-Type' => 'text/html'}, ['OK']] }
  end

  def app
    @app ||= Rack::Host.new(backend, hosts: %w[example.com 10.0.0.0/16])
  end

  def test_that_it_has_a_version_number
    refute_nil ::Rack::Host::VERSION
  end

  def test_passes_on_requests_to_allowed_hosts
    get 'http://example.com/page'
    assert last_response.ok?
  end

  def test_passes_on_requests_when_host_list_contains_cidr
    get 'http://10.0.1.255/page'
    assert last_response.ok?
  end

  def test_404s_requests_to_other_hosts
    get 'http://other.com/page'
    assert_equal 404, last_response.status
    assert_equal 'Not Found', last_response.body
  end

  def test_404s_requests_from_invalid_host_ip
    get 'http://172.1.1.101/page'
    assert_equal 404, last_response.status
    assert_equal 'Not Found', last_response.body
  end

  def test_404s_when_host_ip_parse_fails
    IPAddr.stub(:new, -> { raise InvalidAddressError, 'bad ip' }) do
      get 'http://10.0.1.255/page'
      assert_equal 404, last_response.status
    end
  end
end
