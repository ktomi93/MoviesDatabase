##
# This class responsible to process movies list
class MoviesClient

  def search query
    RestUtil.make_request "search/movie", {:api_key => API_KEY, :query => query}
  end

  def discover
  end

  def configuration
  end

  def get_image
  end

  def get_movie
  end

  def get_genres language
    RestUtil.make_request "genre/movie/list", {:api_key => API_KEY, :language => language}
  end
end