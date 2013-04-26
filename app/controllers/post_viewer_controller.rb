class PostViewerController < ApplicationController
  skip_before_filter :authorize

  def latest
    @post_show = Post.latest
    if @post_show.nil? 
      redirect_to :controller => "user", :action => "login"
      return
    end
    @post_show.hits += 1
    @post_show.save!
    render :view
  end

  def viewall
    @posts = Post.all_visible
  end

  def view
    @post_show = Post.find_by_url_title( params[:url_title] )
    if @post_show.nil?
      raise ActionController::RoutingError.new('Not Found')
    end
    if @post_show.hidden == 1
      raise ActionController::RoutingError.new('Not Found')
    end
    @post_show.hits += 1
    @post_show.save!
  end

  def wp_redirect
    post = Post.find_by_url_title( params[:url_title] )
    if post and post.hidden == 0
      redirect_to :controller => "post_viewer", :action => "view", :url_title => post.url_title, :status => :moved_permanently
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

end
