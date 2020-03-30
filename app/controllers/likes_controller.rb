class LikesController < ApplicationController

    def create
        user = curent_user
        @article = Article.find(params[:id])
        @like = @article.likes.create( article: @article , user: @curent_user )
        @like.save!
        flash[:notice] = 'Liked!'
        redirect_to articles_path
    end

    def destroy
        @article = Article.find(params[:id])
        @like = @article.likes.find_by(params[article: @article , user: @curent_user])
        @like.destroy
        flash[:notice] = 'UnLiked!'
        redirect_to articles_path
    end
end