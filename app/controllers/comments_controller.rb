class CommentsController < ApplicationController
 before_action :require_same_user, only: [:edit, :update]
	
	def show
		@comment = Comment.all
	end
	
	def new
		@comment = Comment.new(params[:@comment])
	end

	def create
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:notice] = 'Your Comment Added'
		else
			flash[:notice] = 'noooo'
		end
		redirect_to articles_path
	end

	def update
		@article = Article.find_by(params[:@article])
		@comment = @article.comments.find(params[:id])
		if @comment.update(params[:comment].permit(:body))
			flash[:notice] = 'Comment Successfully Updated'
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def edit
		@article = Article.find_by(params[:id])
		@comment = @article.comments.find(params[:id])
	end

	def destroy
		@article = Article.find(params[:article_id])
		@comment = @article.comments.find(params[:id])
		@comment.destroy!
		flash[:notice] = 'Comment Was Successfully Deleted'
		redirect_to article_path(@article)
	end

private
	def require_same_user
		if curent_user != @user and !curent_user.admin?
			flash[:danger] = 'al3b b3ed ya shateer :P'
			redirect_to article_path(@article)
		end
	end
	
	def comment_params
		params.require(:comment).permit(:body , :user_id, :article_id)
	end
end