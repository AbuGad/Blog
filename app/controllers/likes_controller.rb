class LikesController < ApplicationController
    before_action :set_article

#    def create
 #       @like = @article.likes.create( article: @article , user: curent_user )
  #      flash[:notice] = 'Liked!'
   #     redirect_to articles_path
    #end

    #def destroy
     #   @like = @article.likes.find_by(params[article: @article , user: curent_user])
      #  @like.destroy
       # flash[:notice] = 'UnLiked!'
        #redirect_to articles_path
    #end

    def toggle
         @likes = @article.likes.where(user: curent_user)

         if @likes.any? 
            @likes.destroy_all
            flash[:notice] = 'UnLiked!'
         else
            Like.create(article: @article, user:curent_user)
            flash[:notice] = 'Liked!'
        end
        redirect_to articles_path
    end

private
    def set_article
        @article = Article.find(params[:id])
    end
end