class StatesController < ApplicationController

  def index
    render layout: "application"
  end

  def all
    @states = %w{al ak az ar ca co ct de fl ga hi id il in ia ks ky la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy}
  end

  def show
    cookies[:state_code] = params[:id]
    @state = UsState.new(params[:id])
    @date = build_date
    @leaders = LeaderSelector.for_day(@state, @date)
    Rails.logger.error(@leaders)

    respond_to do |format|
      format.html
      format.rss { render :layout => false } #show.rss.builder
    end
  end

  def twitter
    @state = UsState.new(params[:id])
    @date = build_date
    @leaders = LeaderSelector.for_day(@state, @date)
    Rails.logger.error(@leaders)

    respond_to do |format|
      format.rss { render :layout => false } #twitter.rss.builder
    end
  end

  def facebook
    @state = UsState.new(params[:id])
    @date = build_date
    @leaders = LeaderSelector.for_day(@state, @date)
    Rails.logger.error(@leaders)

    respond_to do |format|
      format.rss { render :layout => false } #facebook.rss.builder
    end
  end

  def email
    @state = UsState.new(params[:id])
    @date = build_date
    @leaders = LeaderSelector.for_day(@state, @date)

    respond_to do |format|
      format.html { render :layout => false }
      format.rss { render :layout => false }
    end
  end

  private

    def build_date
      year = params[:year] || Date.today.year
      month = params[:month] || Date.today.month
      day = params[:day] || Date.today.day
      Date.new(year.to_i, month.to_i, day.to_i)
    end
end
