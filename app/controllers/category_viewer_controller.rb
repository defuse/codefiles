class CategoryViewerController < ApplicationController
  skip_before_filter :authorize


  def view
    category = Category.find_by_name( params[:name] )

    if category.nil?
      raise ActionController::RoutingError.new( 'Not Found' )
      return
    end

    @category = params[:name]
    @posts = category.posts.where( :hidden => 0 ).order( 'release_date DESC' )
  end

end
