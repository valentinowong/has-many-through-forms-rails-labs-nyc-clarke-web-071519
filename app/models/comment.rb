class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  # accepts_nested_attributes_for :user, reject_if: proc { |attributes| attributes['content'].blank? }
  # accepts_nested_attributes_for :user

  def user_username
    self.user.username
  end

  def users_attributes=(user_attributes)
    user_attributes.values.each do |user_attribute|
      user = User.find_or_create_by(user_attribute)
      self.user = user
    end
  end

end
