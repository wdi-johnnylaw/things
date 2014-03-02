module OpinionsHelper
  def rating_percentage(rating)
    (rating || 0) / 0.0497
  end

  def give_your_opinion_banner(opinion)
    if opinion.persisted?
      "Change of heart? Update your opinion"
    else
      "Please share your opinion"
    end
  end
end
