class ApplicationController < Sinatra::Base
    configure do
        set :views, 'app/views'
        set :method_override, true
      end
    
      get '/' do
        erb :welcome
      end

      get '/puppies' do 
        @puppies = Puppy.all
        # binding.pry
        erb :index
      end

      get '/puppies/new' do 
        erb :new
      end

      get '/puppies/:id' do
        @puppy = find_puppy(params)
        erb :show 
      end

      post '/puppies' do 
        puppy = Puppy.create(params)
        redirect "puppies/#{puppy.id}"
      end

      get '/puppies/:id/edit' do 
        @puppy = find_puppy(params)
        erb :edit
      end

      patch '/puppies/:id' do
        puppy = find_puppy(params)
        puppy.update(name: params[:name], breed: params[:year])
        redirect "/puppies/#{puppy.id}"
      end

      delete '/puppies/:id' do 
        puppy = find_puppy(params)
        puppy.destroy
        redirect '/puppies'
      end

      def find_puppy(params)
          Puppy.find(params[:id])
      end
end
