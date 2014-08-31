# This controller handles Contacts RESTful APIs
class Api::ContactsController < ApiController
  before_filter :find_resource, only: [:show, :update, :destroy]

  JSON_CLASSNAME = :contact
  include ContactScopes

  def index
    @resources = api_scopes(Contact).page(params[:page]).per(params[:per_page])
    render json: @resources
  end

  def create
    @resource = Contact.new(contact_params)
    @resource.save ? render(json: @resource) : render_error(@resource)
  end

  def update
    @resource.update_attributes(contact_params)
    @resource.save ? render(json: @resource) : render_error(@resource)
  end

  def destroy
    @resource.destroy ? render_success : render_error
  end

  private
  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :company)
  end
end
