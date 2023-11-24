require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/gambling.db")

class User
    include DataMapper::Resource
    property :id, Serial #auto increment, primary key
    property :username, String, required: true, unique: true
    property :password, String, required: true
    property :total_wins, Integer, default: 0
    property :total_losses, Integer, default: 0
    property :total_profit, Integer, default: 0
end

DataMapper.finalize

enable(:sessions)

get '/' do
    erb(:welcome_site)
end

get ('/singup') do
    erb(:signup)
end

post '/signup' do
    userObj = User.create(params[:user])
    session[:message] = "Signup Successful"
    redirect('/login')
end

get ('/login') do
    erb(:login)
end

post ('/login') do
    username = params[:username]
    password = params[:password]
  
    # fetching data based on username
    user = User.first(username: username)
  
    if user && user.password == password
        #Login Successful
        session[:user_id] = user.id
        # user.total_profit = user.total_profit + user.total_wins - user.total_losses
        session[:total_wins] = 0
        session[:total_losses] = 0
        session[:total_profit] = 0
        redirect ('/bet')
    else
      # Failed login
      session[:message] = "Invalid username or password"
      redirect('/login')
    end
end

get '/bet' do
    user = User.get(session[:user_id])
    if user
        erb(:betting,  locals: { user: user })
    else
        redirect('/login')
    end
end

post '/bet' do

    redirect '/login' unless session[:user_id]

    # getting user detils
    user = User.get(session[:user_id])

    # betting money got from the user 
    money = params[:bet_money].to_i

    # dice number to bet -- got from the user
    @dice_number = params[:dice_number].to_i

    # random dice roll
    random_dice_num = rand(6) + 1

    # checking if the random roll and user bet dice numbers are equal
    if random_dice_num == @dice_number
        session[:message] = "you won"
        session[:money] = 10 * money
        user.total_wins = user.total_wins + session[:money]
        session[:total_wins] = session[:total_wins] + session[:money]
    else
        session[:message] = "you lost"
        session[:money] = money
        user.total_losses = user.total_losses + money
        session[:total_losses] = session[:total_losses] + session[:money]
    end

    #calculating account profit
    user.total_profit = user.total_wins - user.total_losses
    if user.total_profit < 0
        user.total_profit = 0
    end

    #calculating session profit
    session[:total_profit] = session[:total_wins] - session[:total_losses]
    if session[:total_profit] < 0
        session[:total_profit] = 0
    end

    # saving into database
    user.save

    session[:random_number] = random_dice_num
    redirect ('/bet')
end

get '/logout' do

    redirect '/login' unless session[:user_id]

    #clearing all the session values
    session.clear
    redirect ('/login')
end

  
  
  
  
  
  