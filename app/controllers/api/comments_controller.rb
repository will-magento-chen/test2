# This controller handles Comments RESTful APIs
class Api::CommentsController < ApiController
  before_filter :find_resource, only: [:show, :update, :destroy]

  JSON_CLASSNAME = :comment
  has_scope :by_commentable_id, as: :commentable_id
  has_scope :by_commentable_type, as: :commentable_type

  def index
    @resources = api_scopes(Comment)
    render json: @resources
  end

  def create
    @resource = Comment.new(comment_params)
    @resource.save ? render(json: @resource) : render_error(@resource)
  end

  def destroy
    @resource.destroy ? render_success : render_error
  end

  private
  def comment_params
    params.require(:comment).permit(:commentable_id, :commentable_type, :comment)
  end
end
