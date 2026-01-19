# serializer for user model
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :admin, :created_at

  # including blogs association
  has_many :blogs
  
  # including comments association
  has_many :comments
end
