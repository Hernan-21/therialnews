class NewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_news, only: [ :show, :edit, :update, :destroy ]
  before_action :check_admin, only: [ :destroy ]

  def index
    @news = News.all
  end

  def show
  end
  def my_news
    @news = current_user.news
  end

  def new
    @news = current_user.news.build
  end

  def create
    @news = current_user.news.build(news_params)
    if @news.save
      redirect_to @news, notice: "Noticia creada con éxito."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @news.update(news_params)
      redirect_to @news, notice: "Noticia actualizada con éxito."
    else
      render :edit
    end
  end

  def destroy
    @news.destroy
    redirect_to news_index_path, notice: "Noticia eliminada con éxito."
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:title, :content)
  end

  def check_admin
    redirect_to root_path, alert: "No tienes permisos para realizar esta acción." unless current_user.admin?
  end
end
