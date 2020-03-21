class ArticlesController < ApplicationController

	before_action :set_article, only: [:edit, :update, :destroy]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def index
		@articles = Article.all
	end

	def show
		@article = Article.find(params[:id])
		@article.user = curent_user
		if !logged_in?
			flash[:danger] = 'u must be login'
			redirect_to root_path
		end
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = curent_user
		if @article.save
			flash[:notice] = "Article Was Successfuly created"
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @article.update(article_params)
			flash[:notice] = "Article was Successfuly updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		flash[:notice] = 'article was successfully deleted'
		redirect_to articles_path
	end

private
	def article_params
		params.require(:article).permit(:title, :description)
	end

	def set_article
		@article = Article.find(params[:id])
	end

	def require_same_user
		if curent_user != @article.user
			flash[:danger] = 'matst3batsh ya 7abebi :P'
			redirect_to root_path
		end
	end
end
