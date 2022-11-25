##
# This class responsible to process movies list
class MoviesClient

  def search(query, page = 1)
    cache_hit_count query, page

    query_value = read_cache({ :query => query, :page => page })
    cached = query_value ? true : false
    query_value = query_value || RestUtil.make_request("search/movie", { :api_key => API_KEY, :query => query, :page => page })
    write_cache({ :query => query, :page => page }, query_value)
    { :result => query_value, :cached => cached }
  end

  def discover(page = 1)
    cache_hit_count "/discover/movie", page

    query_value = read_cache({ :query => "/discover/movie", :page => page })
    cached = query_value ? true : false
    query_value = query_value || RestUtil.make_request("/discover/movie", { :api_key => API_KEY, :page => page })
    write_cache({ :query => "/discover/movie", :page => page }, query_value)
    { :result => query_value, :cached => cached }
  end

  def cache_hit_count(query, page)
    hit_count = read_cache({ :query => query + "-hits", :page => page })
    hit_count = hit_count ? hit_count + 1 : 0
    write_cache({ :query => query + "-hits", :page => page }, hit_count)
  end

  def get_genres language
    Rails.cache.fetch "genres_#{language}" do
      RestUtil.make_request("genre/movie/list", { :api_key => API_KEY, :language => language })&.dig("genres")&.to_h {|g| [g["id"], g["name"]]}
    end
  end

  def read_cache(key)
    Rails.cache.read(key, expires_in: 2.minutes)
  end

  def write_cache(key, value)
    Rails.cache.write(key, value, expires_in: 2.minutes)
  end
end