class OpinionsController < ApplicationController
  def create
    @opinion = Opinion.new(opinion_params)

    respond_to do |format|
      if @opinion.save
        flash[:notice] = "Thank you for your opinion!"
        format.html { redirect_to @opinion.thing }
        format.json { render action: 'show', status: :created, location: @opinion }
      else
        flash[:alert] = "Could not handle your opinion!"
        format.html { redirect_to @opinion.thing }
        format.json { render partial: 'shared/messages', status: :bad_request }
      end
    end
  end

  def update
    @opinion = Opinion.find(params[:id])

    respond_to do |format|
      if @opinion.update(opinion_params)
        flash[:notice] = "Thank you for your opinion!"
        format.html { redirect_to @opinion.thing }
        format.json { render action: 'show', location: @opinion }
      else
        flash[:alert] = "Could not update your opinion!"
        format.html { redirect_to @opinion.thing }
        format.json { render partial: 'shared/messages', status: :bad_request }
      end
    end
  end

  private

  def opinion_params
    params.require(:opinion).permit(:thing_id, :rating, :comment).merge(user: current_user)
  end
end
