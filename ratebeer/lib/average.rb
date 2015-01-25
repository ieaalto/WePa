module Average
  def average_rating
    sum = 0
    n = ratings.count
    ratings.each do |rating|
      sum += rating.score/n
    end
    return sum
  end
end