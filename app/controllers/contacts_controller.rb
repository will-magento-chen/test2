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
    @contact.children.build
  end

  def edit
    @contact.children.build if @contact.children.empty?
  end

  def create
    puts params[:format]

    @contact = Contact.new(contact_params)
    if @contact.save
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

  def contact_params
    params.require(:contact)
          .permit(:first_name, :last_name, :email, :company, :address1, :address2, :country, :state,
                  :city, :zipcode, :mobile_phone, :alternate_phone, :interested_buying,
                  :interested_hosting, :interested_joining,
                  children_attributes: [:id, :name, :birthday, :gender, :relationship, :_destroy])
  end

  def find_resource
    @contact = Contact.find(params[:id])
  end
end
