ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  #by default this is true, it will run all test inside a transcation and the database can be quickly rollback after the test, 
  #however, if I want check the database in the middle, I cannot see the changes because it is outside the transcation
  #the database will have all the result data after the test
  self.use_transactional_fixtures = false
  
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #this will clean database and load fixture
  fixtures :all
 
  # Add more helper methods to be used by all tests here...
  
  
  def pause(msg="paused, press return key to continue")
    puts msg
    STDIN.gets
  end
end
