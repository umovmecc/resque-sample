require 'app'
require 'test/spec'
require 'rack/test'
require 'demo'

set :environment, :test

describe "Message" do

  include Rack::Test::Methods

  def app
    TTQ::App
  end

  it "should identify LocalMessageProcessor as processor for messages that start with 'loc'" do
    assert TTQ::MessageProcessor.processor_of('loc local de atendimento').kind_of?(TTQ::LocalMessageProcessor)
  end

  it "should identify AgentMessageProcessor as processor for messages that start with 'age'" do
    assert TTQ::MessageProcessor.processor_of('age blablabla balao').kind_of?(TTQ::AgentMessageProcessor)
  end

  it "should create a queue on the fly, named with the first 3 chars of the message" do
    post '/umovsync/dynamic?mensagem=yammer'
    assert_equal 1, Resque.size(:yam)
  end

end

