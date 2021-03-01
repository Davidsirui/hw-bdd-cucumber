class Movie < ActiveRecord::Base
  
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.with_ratings(ratinglst)
      where("LOWER(rating) IN (?)", ratinglst.map(&:downcase))
  end
end
