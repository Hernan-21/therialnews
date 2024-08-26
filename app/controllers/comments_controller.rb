class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @news = News.find(params[:news_id])
    @comment = @news.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @news, notice: "Comentario creado con éxito."
    else
      redirect_to @news, alert: "Error al crear el comentario."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if current_user.admin? || @comment.user == current_user
      @comment.destroy
      redirect_to @comment.news, notice: "Comentario eliminado con éxito."
    else
      redirect_to @comment.news, alert: "No tienes permisos para eliminar este comentario."
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
