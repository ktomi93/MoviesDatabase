module ApplicationHelper
  def get_poster_image image_path
    if image_path.present?
      image_tag "#{BASE_IMAGE_PATH}t/p/w154#{image_path}"
    else
      image_tag "default-poster.jpg"
    end
  end

  def get_start_interval
    @current_page < 5 ? 1 : @current_page - 3
  end

  def get_end_interval
    @total_pages.blank? || @current_page + 3 < @total_pages ? @current_page + 3 : @total_pages
  end

  def page_navigation_path(path, page_number)
    method(path).call(:search_query => params[:search_query], :page => page_number)
  end

end
