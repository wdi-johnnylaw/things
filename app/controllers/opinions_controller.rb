class OpinionsController < ApplicationController
  def create
    @opinion = Opinion.new(params.require(:opinion).permit(:thing_id, :rating, :comment).merge(user: current_user))

    if @opinion.save
      flash[:notice] = "Thank you for your opinion!"
    else
      flash[:error] = "Could not handle your opinion!"
    end

    redirect_to @opinion.thing
  end
end
