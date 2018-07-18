class LeadersController < ApplicationController
  layout "states"

  def index
    @state = UsState.new(params[:state_id])
  end

  def show
    @leader = LeaderFinder.find(params[:id])
    @state = @leader.state
    l = Logger.new(File.join(Rails.root, "log", "api.log"))
    l.info(@leader)
  end

end
