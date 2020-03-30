class CommentsController < ApplicationController

	def show
		
	end
	
	def new
		@comment = Comment.new(params[:@comment])
	end

	def create
		@article = Article.find_by(params[:id])
		@comment = @article.comments.create(params[:comment].permit(:name, :body))
		redirect_to article_path(@article)
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

end