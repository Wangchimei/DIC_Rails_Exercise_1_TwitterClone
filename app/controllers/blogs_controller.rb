class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit, :update, :show, :destroy]
  layout "header_footer", except: [:home]

  def home
  end

  def index
    @blogs = Blog.all.order(created_at: :desc)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    if params[:back]
      render :new
    else
      if @blog.save
        redirect_to blogs_path, notice: "New quack is now live."
      else
        render :new
      end
    end
  end

  def edit
    @blog = set_blog
  end

  def update
    @blog = set_blog
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "Your quack is updated."
    else
      render :edit
    end
  end

  def show
    @blog = set_blog
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  def destroy
    @blog = set_blog.destroy
    redirect_to blogs_path, notice: "Your quack is successfully deleted."
  end

  private

  def blog_params
    params.require(:blog).permit(:content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end
end
