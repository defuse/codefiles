require 'date'

class PostController < ApplicationController

  def index

  end

  def new
    @post = Post.new
    @selected_categories = []
  end

  def edit
    @post = Post.find( params[:id] )
    @selected_categories = @post.categories.map { |x| x.id }
  end

  def delete
    Post.destroy( params[:id] )
    redirect_to :action => "index"
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not delete post."
    redirect_to :action => "index"
  end

  def save
    if params[:id]
      post = Post.find( params[:id] )
      toRender = :edit
    else
      post = Post.new
      post.hits = 0
      toRender = :new
    end

    post.title = params[:title]
    post.url_title = params[:url_title]
    post.body = params[:body]
    post.modify_date = Time.now.to_date
    post.release_date = Date.parse( params[:published] )
    if params["preview"]
      post.hidden = 1
    elsif post.new_record?
      post.hidden = 0
    end

    @selected_categories = []
    if params[:categories]
      @selected_categories = params[:categories].map { |x| x.to_i }
      post.categories.clear
      params[:categories].each do |catid|
        catg = Category.find(catid.to_i)
        next if catg.nil?
        post.categories << catg
      end
    end

    post.save!

    if post.hidden == 1
      redirect_to( :controller => "post", :action => "preview", :url_title => post.url_title )
    else
      redirect_to( post_url post )
    end

  rescue ActiveRecord::RecordInvalid => e
    @post = post
    flash[:error] = e.message + "."
    render toRender
  end

  def hide
    post = Post.find( params[:id] )
    post.hidden = 1
    post.save!
    redirect_to :action => "index"
  end

  def unhide
    post = Post.find( params[:id] )
    post.hidden = 0
    post.save!
    redirect_to :action => "index"
  end

  def preview
    @post_show = Post.find_by_url_title( params[:url_title] )
    render "post_viewer/view"
  end

end
