class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[edit update destroy]

  def index
    @contacts = Contact.all
    @favorites = Favorite.all
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
    if params[:back]
      render :new
    #respond_to do |format|
    else
      if @contact.save
        ContactMailer.contact_mail(@contact).deliver
        redirect_to @contact, notice: "投稿できました！" 
        #render :show, status: :created, location: @contact
      else
        render :new
      end
    end
  end

  def confirm
    @contact = current_user.contacts.build(contact_params)
    render :new if @contact.invalid?
  end

  def update
      if @contact.update(contact_params)
       redirect_to @contact, notice: "Contact was successfully updated."
       #render :show, status: :ok, location: @contact
      else
        render :edit
      end
  end

  def destroy
    @contact.destroy
    redirect_to contacts_path, notice: "削除しました。"
  end

  private
    def set_contact
      @contact = Contact.find(params[:id])
    end
    def contact_params
      params.require(:contact).permit(:title,:content,:image, :image_cache,:user_id)
    end

    def authenticate_user!
      @contact = Contact.find(params[:id])
      unless current_user.id == @contact.user.id
      flash[:notice] = "権限がないです。"
      redirect_to contacts_path
      end
    end
end
