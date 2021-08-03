class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]

  def index
    @contacts = Contact.all
  end

  def show
    @favorite = current_user.favorites.find_by(contact_id: @contact.id)
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = current_user.contacts.build(contact_params)

    respond_to do |format|
      if @contact.save
        ContactMailer.contact_mail(@contact).deliver
        format.html { redirect_to @contact, notice: "投稿できました！" }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm
    @contact = current_user.contacts.build(contact_params)
    render :new if @contact.invalid?
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to @contact, notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "削除しました。" }
      format.json { head :no_content }
    end
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :content,:image, :image_cache,:user_id)
    end
end
