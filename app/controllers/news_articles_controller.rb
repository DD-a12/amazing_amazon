class NewsArticlesController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create ,:edit]
        def index
            @news_articles = NewsArticle.all
        end
    
        def new
            @news_article =NewsArticle.new
        end
    
        def create
            @news_article = NewsArticle.new news_article_params
            @news_article.user = current_user
            if @news_article.save
                redirect_to news_article_path(@news_article)
            else
                render :new
            end
        end
    
        def show
            find_params
        end
    
        def destroy
            find_params
            @news_article.destroy
            redirect_to news_article_path
        end
    
        def edit
            find_params
            if can? :crud, @news_article
            else
                flash[:danger] == "Access Denied"
                redirect_to job_post_path(job_post)
            end
        end
        
        def update
            find_params
            if news_article.update
                flash[:notice] = 'news_article updated Successfully'
                redirect_to news_article_path(@news_article)
            else
                render :edit
            end
        end
    
        private
        def find_params
            @news_article=NewsArticle.find params[:id]
        end
        def news_article_params
            params.require(:news_article).permit(:title, :description, :published_at)
        end
end
