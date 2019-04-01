class SubscriptionsController < ApplicationController
  layout "states"

  def show
    @state = UsState.new(params[:state_id])
    @segment = MailListSegment.new(@state, params[:id])
    @subscription = Subscription.new(
      state_code: params[:state_id],
      cycle: params[:id]
    )
  end

  def subscribe
    @subscription = Subscription.new(params[:subscription])
    begin
      if @subscription.save
        flash[:success] = "You have successfully subscribed to the #{@subscription.segment.public_name}"
      end
    rescue Exception => e
      flash[:success] = "Your subscription could not be created. This is generally because you have already subscribed."
    end
    redirect_to root_path
  end

  def create
    #debugger
    params['subscription']['full_name'] = params['subscription'].delete('name')
    @state = UsState.new(params[:state_id])
    @subscription = Subscription.new(params[:subscription])
    begin
      if @subscription.save
        flash[:success] = "You have successfully subscribed to the #{@subscription.segment.public_name}"
      end
    rescue Exception => e
      flash[:success] = "Your subscription could not be created.  This is generally because you have already subscribed."
    end
    redirect_to state_subscription_path(@state.to_param, @subscription.cycle)
  end
end
