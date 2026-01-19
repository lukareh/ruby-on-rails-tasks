# serializer for comment model
class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :author, :created_at, :updated_at, :user_name

  # including blog association
  belongs_to :blog
  
  # including user association
  belongs_to :user

  # custom attribute for user name
  def user_name
    object.user&.name
  end
end
