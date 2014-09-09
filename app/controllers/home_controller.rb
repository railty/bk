class HomeController < ApplicationController
  def top
    @mds = Node.top
  end
end
