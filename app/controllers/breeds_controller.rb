class BreedsController < ApplicationController
  def index
    @breeds = if params[:search_term]
      Breed.by_name_search(params[:search_term])
    else
      Breed.order(:name)
    end
  end

  def destroy
    @breed = Breed.find(params[:id])
    @breed.destroy

    respond_to do |format|
      format.html { redirect_to breeds_path }
      format.turbo_stream
    end
  end
end
