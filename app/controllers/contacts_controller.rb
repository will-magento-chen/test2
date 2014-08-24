class ContactsController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new
    @contact.country = 'US'
  end

  def edit
    @contact.children.build if @contact.children.empty?
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contacts_path, notice: "Contact has been created successfully"
    else
      redirect_to :back, alert: @contact.errors.full_messages
    end
  end

  def update
    if @contact.update_attributes(contact_params)
      redirect_to contacts_path, notice: "Contact has been updated successfully"
    else
      render :edit
    end
  end

  private

  def contact_params
    params.require(:contact)
          .permit(:first_name, :last_name, :email, :company, :address1, :address2, :country, :state,
                  :city, :zipcode, :mobile_phone, :alternate_phone,
                  children_attributes: [:id, :name, :birthday, :gender, :relationship, :_destroy])
  end

  def find_resource
    @contact = Contact.find(params[:id])
  end
end
