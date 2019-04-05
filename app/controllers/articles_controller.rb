class ArticlesController < ApplicationController
  before_action :get_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was susccessfully created"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:success] = "Article was susccessfully updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @article.destroy
    flash[:danger] = 'Article was successfully deleted'
    redirect_to articles_path
  end

  private

  def get_article
    @article = Article.find(params[:id])
  end

  def set_article

  end
  def article_params
    params.require(:article).permit(:title, :description)
  end
end