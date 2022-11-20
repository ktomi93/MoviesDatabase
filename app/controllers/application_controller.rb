class ApplicationController < ActionController::Base

  # after_action :get_genres, :only => [:home]
  # after_action :get_configuration, :only => [:home]
  before_action :init

  def home
    result = @client.discover @current_page
    @movies = result["results"]
    # logger.info RestUtil.make_request "movie/550", {:api_key => "9b27b7cd4dcd6fa71a7df5ee7f66038c1"}
  end

  def search
    result = @client.search params[:search_query], @current_page
    @movies = result["results"]
    @total_pages = result["total_pages"]
    @total_results = result["total_results"]
  end

  # def get_genres
  #   @genres = @client.get_genres "en-US"
  # end
  #
  # def get_configuration
  #   @genres = @client.get_configuration
  # end

  def init
    @client = MoviesClient.new
    @current_page = params[:page].present? ? params[:page].to_i : 1
  end

end
