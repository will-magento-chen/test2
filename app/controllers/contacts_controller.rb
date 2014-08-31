class ContactsController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  include ContactScopes

  def index
    @contacts = apply_scopes(Contact).page(params[:page]).per(10).order(id: :desc)
    respond_to do |format|
      format.html
      format.csv { send_data @contacts.to_csv }
    end
  end

  def new
    @contact = Contact.new
    @contact.country = 'US'
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      @contact.comments.create({comment: params[:note]}) if params[:note].present?
      add_children
      respond_to do |format|
        format.json { render json: @contact, status: :created }
        format.html { redirect_to @contact, notice: "Event has been created successfully" }
      end
    else
      respond_to do |format|
        format.json { render json: @contact.errors.full_messages, status: :unprocessable_entity }
        format.html { render :new }
      end
    end
  end

  def update
    if @contact.update_attributes(contact_params)
      redirect_to contacts_path, notice: "Contact has been updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: "Contact has been deleted successfully."
  end

  private

  def add_children
    return if @contact.nil? or params[:children].nil?

    @contact.children.destroy_all
    params[:children].each do |child|
      next if child.name.blank?
      @contact.children.create(child_params(child))
    end
  end

  def contact_params
    params.require(:contact)
          .permit(:first_name, :last_name, :email, :company, :address1, :address2, :country, :state,
                  :city, :zipcode, :mobile_phone, :alternate_phone, :interested_buying,
                  :interested_hosting, :interested_joining)
  end

  def child_params(child_param)
    child_param.permit(:name, :birthday, :gender, :relationship)
  end

  def find_resource
    @contact = Contact.find(params[:id])
  end
end
