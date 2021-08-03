class FavoritesController < ApplicationController
    def create
      favorite = current_user.favorites.create(contact_id: params[:contact_id])
      redirect_to contacts_path, notice: "#{favorite.contact.user.name}さんのブログをお気に入り登録しました"
    end
    def destroy
      favorite = current_user.favorites.find_by(id: params[:id]).destroy
      redirect_to contacts_path, notice: "#{favorite.contact.user.name}さんのブログをお気に入り解除しました"
    end
end