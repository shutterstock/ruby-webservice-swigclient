require 'spec_helper'
require 'json'
describe WebServiceSwigClient do
  it "initialize and perform a render request" do
    open_params = []
    print_params = []
    require 'curly'
    class Curly::Request;end
    class MockResponse;end
    MockResponse.singleton_class.class_eval { define_method('status'){|*params| 200 }}
    MockResponse.singleton_class.class_eval { define_method('body'){|*params| 'foobar' }}
    Curly::Request.singleton_class.class_eval { define_method('post'){|*params| open_params.push(params); MockResponse }}

    client = WebServiceSwigClient.new(:api_key => '123', :service_url => 'http://localhost' )

    expect(client).to be_an_instance_of(WebServiceSwigClient)
    expect(client.render('foo.html', {foo:'bar'})).to eq 'foobar'
    expect(open_params[0]).to eq ["http://localhost/123/foo.html", {:headers=>{"Content-type"=>"application/json"}, :body=>"{\"foo\":\"bar\"}"}]

  end

  it "will call excpection callback if non 200 is returned" do
    open_params = []
    print_params = []
    require 'curly'
    class Curly::Request;end
    class MockResponse;end
    MockResponse.singleton_class.class_eval { define_method('status'){|*params| 400 }}
    MockResponse.singleton_class.class_eval { define_method('body'){|*params| 'foobar' }}
    Curly::Request.singleton_class.class_eval { define_method('post'){|*params| open_params.push(params); MockResponse }}

    client = WebServiceSwigClient.new(
      :api_key       => '123',
      :service_url   => 'http://localhost',
      :error_handler => Proc.new{|error|
        expect(error).to eq 'There was a problem communicating with the server'
      }
    )

    expect(client).to be_an_instance_of(WebServiceSwigClient)
    expect(client.render('foo.html', {foo:'bar'})).to eq true
    expect(open_params[0]).to eq ["http://localhost/123/foo.html", {:headers=>{"Content-type"=>"application/json"}, :body=>"{\"foo\":\"bar\"}"}]

  end
end
