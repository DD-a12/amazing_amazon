require 'rails_helper'

RSpec.describe NewsArticlesController, type: :controller do
    def current_user
        @current_user ||= FactoryBot.create(:user)
    end

    describe '#new' do
        context 'when user is not signed in' do
            it 'should redirect to session#new' do
                get(:new)
                expect(response).to redirect_to(new_session_path)
            end
            it 'sets a flash danger message' do 
                get(:new)
                expect(flash[:danger]).to be
            end
        end
        context 'when user is signed in' do
            before do
                session[:user_id] = current_user.id
            end
            it 'should render new template' do
                get(:new)
                expect(response).to(render_template(:new))
            end
            it 'should set an instance variable with a new job post' do
                get(:new)
                expect(assigns(:news_article)).to(be_a_new(NewsArticle))
            end
        end
    end

    describe '#create' do
        def valid_request 
            post(:create, params: { news_article: FactoryBot.attributes_for(:news_article)})
        end
        context 'when user is not signed in' do
            it 'should redirect to session#new' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
            it 'sets a flash danger message' do 
                valid_request
                expect(flash[:danger]).to be
            end
        end
        context 'when user is signed in' do
            before do
                session[:user_id] = current_user.id
            end
            context 'with valid parameters' do
                it 'should create news article in db' do
                    count_before = NewsArticle.count
                    valid_request
                    count_after = NewsArticle.count 
                    expect(count_after).to eq(count_before + 1)
                end
                it 'should redirect to news_article_path(@news_article)' do
                    valid_request
                    news_article = NewsArticle.last
                    expect(response).to redirect_to(news_article_path(news_article))
                end 
                it 'should associate current user to news article' do
                    valid_request
                    news_article = NewsArticle.last
                    expect(news_article.user).to eq(current_user)
                end
            end
            context 'with invalid parameters' do
                def invalid_request 
                    post(:create, params: { news_article: FactoryBot.attributes_for(:news_article, title: nil)})
                end
                it 'should assign an invalid news_article as an instance variable' do 
                    invalid_request
                    expect(assigns(:news_article)).to be_a(NewsArticle)
                    expect(assigns(:news_article).valid?).to be(false)
                end
                it 'should render to #new' do
                    invalid_request
                    expect(response).to(render_template(:new)) 
                end
                it 'should not create a news article in the db' do 
                    count_before = NewsArticle.count
                    invalid_request
                    count_after = NewsArticle.count 
                    expect(count_after).to eq(count_before)
                end
            end
        end
    end

    describe '#edit' do
        def valid_request 
        post(:create, params: { news_article: FactoryBot.attributes_for(:news_article)})
        end
        context 'when user is not signed in' do
            it 'should redirect to session#new' do
                valid_request
                expect(response).to redirect_to(new_session_path)
            end
            it 'sets a flash danger message' do 
                valid_request
                expect(flash[:danger]).to be
            end
        end
        context 'when user is signed in' do
            before do 
                session[:user_id] = current_user.id
            end
            context 'user as non-owner' do
                it 'flash danger ' do
                   
                end
            end
        end
    end

end
