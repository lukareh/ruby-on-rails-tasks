# serializer for blog model
class BlogSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published, :created_at, :updated_at, :user_name

  # including comments association
  has_many :comments
  
  # including user association
  belongs_to :user

  # custom attribute for user name
  def user_name
    object.user&.name
  end
end
