class Api::ArticlesController < ApplicationController
  respond_to :json

  def index

    articles = Article.all

    return render status: 200, json: articles
  end

  def create
    article = Article.create!(params[:article])

    return render status: 201, json: article
  end

end
