##
# This class responsible to process movies list
class MoviesClient

  def search(query, page = 1)
    RestUtil.make_request "search/movie", { :api_key => API_KEY, :query => query, :page => page }
  end

  def get_configuration
    RestUtil.make_request "configuration", {:api_key => API_KEY}
  end

  def get_genres(language)
    RestUtil.make_request "genre/movie/list", { :api_key => API_KEY, :language => language }
  end

  def discover(page = 1)
    RestUtil.make_request "/discover/movie", { :api_key => API_KEY, :page => page }
  end

end