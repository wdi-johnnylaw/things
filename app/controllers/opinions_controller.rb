class OpinionsController < ApplicationController
  def create
    @opinion = Opinion.new(opinion_params)

    if @opinion.save
      flash[:notice] = "Thank you for your opinion!"
    else
      flash[:error] = "Could not handle your opinion!"
    end

    redirect_to @opinion.thing
  end

  def update
    @opinion = Opinion.find(params[:id])

    if @opinion.update(opinion_params)
      flash[:notice] = "Thank you for your opinion!"
    else
      flash[:error] = "Could not update your opinion!"
    end
    redirect_to @opinion.thing
  end

  private

  def opinion_params
    params.require(:opinion).permit(:thing_id, :rating, :comment).merge(user: current_user)
  end
end
