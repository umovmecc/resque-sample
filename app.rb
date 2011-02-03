require 'sinatra/base'
require 'sinatra'
require 'resque'
require 'demo'
require 'ttmessage'

module TTQ

  class App < Sinatra::Base

    get '/frameset' do
      erb :frameset, :layout => false
    end

    get '/' do
      @info = Resque.info
      erb :home
    end

    post '/' do
      Resque.enqueue(Demo::Job, params)
      redirect "/"
    end

    post '/failing' do
      Resque.enqueue(Demo::FailingJob, params)
      redirect "/"
    end

    post '/umovsync' do
      Resque.enqueue(TTMessage, params[:mensagem])
      redirect '/'
    end

    # create queues on the fly, named with the 3 first characters of the message
    post '/umovsync/dynamic' do
      Resque.push(MessageProcessor.type_of(params[:mensagem]), params[:mensagem] )
      redirect '/'
    end

  end

end

