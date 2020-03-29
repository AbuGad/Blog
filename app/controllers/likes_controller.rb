class LikesController < ApplicationController

    def create
        user = curent_user
        @article = Article.find(params[:id])
        @like = Like.create( article: @article , user: @curent_user)
        @like.save!
        flash[:notice] = 'Liked!'
        redirect_to articles_path
    end

    def destroy
            @user = curent_user.likes
            @article = Article.find(params[:id])
            @like = Like.find_by(params[article: @article , user: @curent_user])
            @like.destroy
            flash[:notice] = 'UnLiked!'
            redirect_to articles_path
        end
end