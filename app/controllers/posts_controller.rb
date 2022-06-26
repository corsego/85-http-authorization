class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  # http_basic_authenticate_with name: 'superails', password: '123', except: %i[index show]
  # http_basic_authenticate_with name: Rails.application.credentials.dig(:http_auth, :name).to_s,
  #                              password: Rails.application.credentials.dig(:http_auth, :pass).to_s,
  #                              except: %i[index show]
  before_action :http_auth, except: %i[index show]

  def index
    @posts = Post.all
  end

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: 'Post was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_url, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def http_auth
    return true if Rails.env == 'development'

    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.dig(:http_auth, :name).to_s &&
        password == Rails.application.credentials.dig(:http_auth, :pass).to_s
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
