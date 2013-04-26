class CategoryController < ApplicationController

  def index
    render :index
  end

  def create
    newCat = Category.new
    newCat.name = params[:name]
    unless newCat.save 
      flash[:error] = "A category with that name already exists."
    end
    redirect_to :controller => "category", :action => "index"
  end

  # TODO: make sure what happens to the join table is something sane

  def delete
    Category.destroy( params[:category_id] )
    redirect_to :controller => "category", :action => "index"
  rescue ActiveRecord::RecordNotFound
    flash[:error] = "Could not delete category."
    redirect_to :controller => "category", :action => "index"
  end

  def rename
    category = Category.find( params[:category_id] )
    category.name = params[:newname]
    unless category.save
      flash[:error] = "Invalid or duplicate name."
    end
    redirect_to :controller => "category", :action => "index"
  end

end
