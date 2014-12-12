class SearchController < ApplicationController
  before_action :set_query, only: [:index]

  # GET /search/:query
  def index
    date_lower_bound = ""
    date_upper_bound = ""
    error_encountered = false

    if params[:query].blank?
      flash[:error] = "Please enter a search query"
      @results = []
      error_encountered = true
    end


    unless error_encountered
      unless params[:date_lower_bound].blank?
        begin
          date_lower_bound = Date.strptime(params[:date_lower_bound].to_s, '%m/%d/%Y')
        rescue
          flash[:error] = "Invalid lower-bound date"
          @results = []
          error_encountered = true
        end
      end
    end

    unless error_encountered
      unless params[:date_upper_bound].blank?
        begin
          date_upper_bound = Date.strptime(params[:date_upper_bound].to_s, '%m/%d/%Y')
        rescue
          flash[:error] = "Invalid upper-bound date"
          @results = []
          error_encountered = true
        end
      end
    end

    unless error_encountered
      if not date_lower_bound.blank? and not date_upper_bound.blank?
        if date_lower_bound < date_upper_bound
          @search = Sunspot.search [Journey, Entry, User] do
            keywords(params[:query])
            with(:created_at).between(date_lower_bound..date_upper_bound)
          end
          flash[:info] = "Upper and Lower bounds"
          @results = @search.results
        else
          puts date_lower_bound.to_s
          puts date_upper_bound.to_s
          puts (date_lower_bound <=> date_upper_bound).to_s
          flash[:error] = "Invalid date range"
          @results = []
        end
      elsif not date_lower_bound.blank?
        @search = Sunspot.search [Journey, Entry, User] do
          keywords(params[:query])
          with(:created_at).greater_than(date_lower_bound)
        end
        flash[:info] = "Lower bound"
        @results = @search.results
      elsif not date_upper_bound.blank?
        @search = Sunspot.search [Journey, Entry, User] do
          keywords(params[:query])
          with(:created_at).less_than(date_upper_bound)
        end
        flash[:info] = "Upper bound"
        @results = @search.results
      end
    end

    unless error_encountered
      if date_lower_bound.blank? and date_upper_bound.blank?
        @search = Sunspot.search [Journey, Entry, User] do
          keywords(params[:query])
        end
        flash[:info] = "only keywords"
        @results = @search.results
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_query
      @query = params[:query]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:query, :date_lower_bound, :date_upper_bound)
    end
end
