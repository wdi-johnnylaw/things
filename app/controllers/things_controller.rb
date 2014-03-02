class ThingsController < ApplicationController
  def index
    @things = Thing.all
  end

  def show
    @thing = Thing.find params[:id]
    @opinion = @thing.opinions.find_by(user_id: current_user.id) || Opinion.new
  end
end
