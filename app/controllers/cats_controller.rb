class CatsController < ApplicationController
  def index
    @cats = if params[:breed_name]
      Cat.by_breed_name(params[:breed_name])
    else
      Cat.by_newest(params[:page])
    end
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy

    respond_to do |format|
      format.html { redirect_to cats_path }
      format.turbo_stream
    end
  end
end
