class UsersController < ApplicationController
  before_action :authenticate_user!

  layout 'registration'

  def show
    @plan = Plan.first
    @user_preference_options = Preference.profile
    @subscription_preference_options = Preference.subscription
  end
end
