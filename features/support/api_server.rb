#-----------------------------------------------------------------------------79
# Remote server for emulating the API server
# (c) 2012 RedRover
#-------------------------------------------------------------------------------
require 'sinatra/base'
require_relative 'server_helper'

class ApiServer < Sinatra::Base
  set :protection, :except => :frame_options
  set :logging, true
  @@place_comment_added,@@event_comment_added = false
  include Helpers

  before do
    content_type :json
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
    headers['Access-Control-Max-Age'] = '86400'
  end

  get "/api/v3/categories" do
    filename = "categories_#{params[:type]}"
    File.read(File.join(File.dirname(__FILE__), "api_responses/#{filename}"))
  end

  get "/api/v3/:api_call" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/#{params[:api_call]}"))
  end

  get "/api/v3/events/search" do
    result  =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/category_1"))  
    if params.has_key?("action_date") &&  params.has_key?("age_scope")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/#{params[:action_date]}_#{params[:age_scope]}"))  
    end

    if params.has_key?("action_date") &&  !params.has_key?("age_scope")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/#{params[:action_date]}"))  
    end

    if params.has_key?("action_date") &&  params.has_key?("most_starred")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/#{params[:action_date]}_most_starred"))  
    end

    if params.has_key?("action_date") &&  params.has_key?("by_followers")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/#{params[:action_date]}_by_followers"))  
    end

    if params.has_key?("text")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/search_result"))
    end

    if params.has_key?("places_ids")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/events/search/search_result_by_places_#{params[:places_ids]}"))
    end

    result
  end

  get "/api/v3/places/search" do
    result  =  File.read(File.join(File.dirname(__FILE__), "api_responses/places/search/category_all"))  
    
    if params.has_key?("categories_ids")
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/places/search/search_result_by_categories_#{params[:categories_ids]}"))
    end

    if !params.has_key?("categories_ids") && params[:distance] = "0.5mi"
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/places/search/search_result_empty"))
    end

    if params.has_key?("by_followers") 
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/places/search/search_result_by_followers"))
    end

    if params.has_key?("most_starred") 
      result =  File.read(File.join(File.dirname(__FILE__), "api_responses/places/search/search_result_most_starred"))
    end

    result
  end
  
  get "/api/v3/publishers/:publisher_id" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/publisher/#{params[:publisher_id]}"))
  end
  
  get "/api/v3/events/:event_id" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/events/#{params[:event_id]}"))
  end

  get "/api/v3/events/:event_id/nearby" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/events/nearby_#{params[:event_id]}"))
  end
  
  get "/api/v3/places/:place_id" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/places/#{params[:place_id]}"))
  end
  
  get "/api/v3/publishers/my_following_publishers" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/publisher/my_following_publishers"))
  end

  post "/api/v3/users" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/success_signup"))
  end

  get "/api/v3/users/:id" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/#{params[:id]}"))
  end

  post "/api/v3/users/:id/follow" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/follow/#{params[:id]}"))
  end

  post "/api/v3/users/:id/unfollow" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/unfollow/#{params[:id]}"))
  end

  post "/api/v3/users/following" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/following"))
  end

  post "/api/v3/users/login" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/success_signin"))
  end

  post "/api/v3/users/login_with_social" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/login_with_social"))
  end

  get "/api/v3/users/current_user_info" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/current_user_info"))
  end

  post "/api/v3/users/change_user_privacy" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/change_user_privacy"))
  end

  post '/api/v3/users/change_personal_info' do
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/change_personal_info"))
  end

  get "/api/v3/places/:place_id/comments" do
    if @@place_comment_added
      @@place_comment_added=false
      return File.read(File.join(File.dirname(__FILE__), "api_responses/places/comments/1_add"))
    end
    File.read(File.join(File.dirname(__FILE__), "api_responses/places/comments/1"))
  end

  post "/api/v3/places/:id/star" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/places/star_#{params[:id]}"))
  end

  post "/api/v3/events/:id/star" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/places/star_#{params[:id]}"))
  end

  post "/api/v3/publishers/:publisher_id/follow" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/publisher/follow"))
  end
  
  post "/api/v3/places/:place_id/add_comment" do
    @@place_comment_added = true
    File.read(File.join(File.dirname(__FILE__), "api_responses/places/comments/add_comment"))
  end

  get "/api/v3/events/:event_id/comments" do
    if @@event_comment_added
      @@event_comment_added=false
      return File.read(File.join(File.dirname(__FILE__), "api_responses/events/comments/1_add"))
    end
    File.read(File.join(File.dirname(__FILE__), "api_responses/events/comments/1"))
  end

  post "/api/v3/events/:event_id/add_comment" do
    @@event_comment_added = true
    File.read(File.join(File.dirname(__FILE__), "api_responses/events/comments/add_comment"))
  end

  post "/api/v3/publishers/:publisher_id/unfollow" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/publisher/unfollow"))
  end


  post '/api/v3/users/change_password' do
    current_password = "admin123"
    result_name = "change_password_success"
    result_name = "change_password_failure" if params[:current_password] != current_password
    File.read(File.join(File.dirname(__FILE__), "api_responses/users/#{result_name}"))
  end

  get '/api/v3/places/:place_id/publishers' do
    File.read(File.join(File.dirname(__FILE__), "api_responses/places/publishers/publisher_#{params[:place_id]}"))
  end

  get "/api/v3/activities" do
    File.read(File.join(File.dirname(__FILE__), "api_responses/activities"))
  end

end

if __FILE__ == $0
  ApiServer.run! :host => 'localhost', :port => 9090
end