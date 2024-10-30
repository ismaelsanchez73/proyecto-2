class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index] # Permite acceso a index sin autenticación
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params) # Asociar el artículo con el usuario actual
    if @article.save
      redirect_to @article, notice: 'Artículo creado exitosamente.'
    else
      render 'new'
    end
  end

  def edit
    # @article ya se establece en el before_action :set_article
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Artículo actualizado exitosamente.'
    else
      render 'edit'
    end
  end

  def show
    # @article ya se establece en el before_action :set_article
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: 'Artículo no encontrado.'
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: 'Artículo eliminado exitosamente.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def authorize_user!
    unless @article.user_id == current_user.id
      redirect_to articles_path, alert: 'No tienes permiso para eliminar este artículo.'
    end
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end
end
