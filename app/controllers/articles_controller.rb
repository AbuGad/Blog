class ArticlesController < ApplicationController

	before_action :set_article, only: [:edit, :update, :destroy, :private, :public, :show]
	before_action :require_user, except: [:index, :show]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	
	def index
		@articles = Article.all
	end

	def show
		if !logged_in?
			flash[:danger] = 'You Have To Login First'
			return 
			redirect_to root_path
		end
		if @article.private? 
			flash[:notice] = 'Hidden Content, Ask User To Make It Puplic First'
			redirect_to articles_path
		end
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		@article.user = curent_user
		if @article.save
			flash[:success] = "Article Was Successfuly Created"
			redirect_to article_path(@article)
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @article.update(article_params)
			flash[:success] = "Article was Successfuly Updated"
			redirect_to article_path(@article)
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy
		flash[:danger] = 'Article was Successfully Deleted'
		redirect_to articles_path
	end

	def private
		if @article.private_article!
			flash[:notice] = 'Now it Private'
			redirect_to articles_path
		end
	end

	def public
		if @article.public_article!	
			flash[:notice] = 'Now It Public'
			redirect_to article_path(@article)
		end
	end

private

	def article_params
		params.require(:article).permit(:title, :description)
	end

	def set_article
		@article = Article.find(params[:id])
	end

	def require_same_user
		if curent_user != @article.user and !curent_user.admin?
			flash[:danger] = 'You Can Only edit and Upadate your Articles'
			redirect_to root_path
		end
	end
end