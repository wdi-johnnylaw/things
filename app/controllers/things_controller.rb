class ThingsController < ApplicationController
  def index
    respond_to do |format|
      format.json { @things = Thing.all }
      format.html {}
    end
  end

  def show
    respond_to do |format|
      format.json { @thing = Thing.find params[:id] }
      format.html { @thing = Thing.find params[:id] }
    end
  end
end
