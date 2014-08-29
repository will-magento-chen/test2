# Base controller for api controllers
class ApiController < ApplicationController
  skip_before_filter :authenticate_user!
  before_filter :authenticate
  after_filter :set_pagination, only: [:index]
  before_filter :initialize_per_page, only: [:index]

  # app_responders help to determine what version of the API controllers to use

  respond_to :json

  def show
    render json: @resource
  end

  def update
    @resource.update_attributes(permitted_params)
    @resource.save ? render(json: @resource) : render_error(@resource)
  end

  def destroy
    @resource.destroy ? render_success : render_error
  end

  def render_success(extra = {})
    render json: extra
  end

  def render_error(entity = nil)
    if entity.nil?
      render json: {}, status: :unprocessable_entity
    else
      render json: entity.errors.full_messages, status: :unprocessable_entity
    end
  end

  # Set root to false as this helps standardize things for the front-end.
  # No need to repeat in each controller call.
  def default_serializer_options
    {
      root: false
    }
  end

  protected

  def find_resource
    @resource = controller_name.classify.constantize.find(params[:id])
  end

  def set_pagination
    scope = @resources
    page = {}

    page[:per_page] = scope.limit_value.to_s
    page[:current_page] = scope.current_page
    page[:next_page] = scope.current_page + 1 unless scope.last_page?
    page[:prev_page] = scope.current_page - 1 unless scope.first_page?
    page[:total] = scope.total_count.to_s
    response.headers['page'] = page
  end

  def initialize_per_page
    params[:per_page] ||= 25
  end

   def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      token == api_token
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Invalid Access Token', status: 401
  end

  def api_token
    'KFKECHZ2YHKM3SE5KYU6'
  end

end
