class CommuterRailController < ApplicationController

  def index
    @times = CommuterRailService.new.hash
  end

end
