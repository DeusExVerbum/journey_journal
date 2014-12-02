class SearchController < ApplicationController
  before_action :set_query, only: [:index]

  # GET /search/:query
  def index
    #@search = Journey.search do
      #keywords(params[:query])
    #end
    @search = Sunspot.search [Journey, Entry, User] do
      keywords(params[:query])
    end

    @results = @search.results
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = params[:query]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:query)
    end
end
