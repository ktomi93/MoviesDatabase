module ApplicationHelper
  def get_poster_image(image_path, title)
    if image_path.present?
      image_tag "#{BASE_IMAGE_PATH}t/p/w154#{image_path}", class: "image-size", alt: title
    else
      image_tag "default-poster.jpg", alt: title
    end
  end

  def get_start_interval
    @current_page_number < 5 ? 1 : @current_page_number - 3
  end

  def get_end_interval
    @total_pages.blank? || @current_page_number + 3 < @total_pages ? @current_page_number + 3 : @total_pages
  end

  def page_navigation_path(path, page_number)
    method(path).call(:search_query => params[:search_query], :page => page_number)
  end

  def genres ids
    ids.map do |id|
      @genres[id]
    end.join(", ")
  end

end
