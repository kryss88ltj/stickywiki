class SubscriptionsController < ApplicationController

  def new
     @plan = Plan.find(params[:plan_id]) 
     @subscription = @plan.subscriptions.build
     # @subscription = Subscription.new(plan_id: params[:plan_id])
  end


  def create
    @user = current_user
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user 
    
    if @subscription.save_with_payment
       @user.subscription_id = @subscription.id
       @user.subscribed = true
       @user.save
      redirect_to root_path, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    puts params.inspect
    @subscription = Subscription.find(current_user.subscription_id)
  end

private

  def subscription_params
      params.require(:subscription).permit(:plan_id, :email, :stripe_card_token)
  end

end