module OpinionsHelper
  def rating_percentage(rating)
    (rating || 0) / 0.0497
  end
end
