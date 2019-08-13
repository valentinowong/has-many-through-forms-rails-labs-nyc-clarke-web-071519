class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end

  def user_comments
    hash = {}
    self.comments.each do |comment|
      if hash[comment.user_username]
        hash[comment.user_username] << comment.content
      else
        hash[comment.user_username] = [comment.content]
      end
    end
    hash
  end
end
