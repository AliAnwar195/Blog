class ArticlesController < ApplicationController
  before_action :authenticate_user!
  # http_basic_authenticate_with name: "ali", password: "secret", except: [:index, :show, :welcome]  #only allow user with name and password to create a article

  # to show all articles 
  def index
    @articles = Article.all
  end

  # to show a specific article
  def show
    @article = Article.find(params[:id])
  end

  # make new article
  def new
    @article = Article.new
  end

  # create new article
  def create
    @article = Article.new(article_params)

    # if articles is save redirect to the main page else render same new page and show an error
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  # find the article to edit
  def edit
    @article = Article.find(params[:id])
  end

  # update the article 
  def update
    @article = Article.find(params[:id])

    # if article is updated redirect to the specific article page  else remain on same page and through a error
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
