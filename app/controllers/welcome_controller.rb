# Controller for serving the welcome page, root route 
# redirects to it. Has beencreated specifically for 
# the devise gem (which requires active root route
# in ./config/routes.rb). Might be replaced later on 
# when a better candidate for welcome page arises.
class WelcomeController < ApplicationController
  def index
  end
end
