class ApplicationController < ActionController::Base

  before_action :init

  @@language_map = {:en => "en-US"}

  def home
    result = @client.discover @current_page_number
    @cached = result[:cached]
    result = result[:result]
    if result
      @movies = result["results"]
    end
  end

  def search
    @searched_query = params[:search_query]
    result = @client.search @searched_query, @current_page_number
    @cached = result[:cached]
    result = result[:result]
    if result
      @movies = result["results"]
      @total_pages = result["total_pages"]
      @total_results = result["total_results"]
    end
  end

  def init
    @client = MoviesClient.new
    @current_page_number = params[:page].present? ? params[:page].to_i : 1
    @genres = @client.get_genres(@@language_map[I18n.locale])
  end

end
