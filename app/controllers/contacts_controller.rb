class ContactsController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.page(params[:page]).per(10)
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to contacts_path, notice: "Contact has been created successfully"
    else
      redirect_to :back, alert: "Unable to create contact"
    end
  end

  def update
    if @contact.update_attributes(contact_params)
      redirect_to contacts_path, notice: "Contact has been updated successfully"
    else
      redirect_to :back, alert: "Unable to update contact"
    end
  end

  private

  def contact_params
    params.require(:contact).permit!
  end

  def find_resource
    @contact = Contact.find(params[:id])
  end
end
