class WikisController < ApplicationController
  def index
    @wikis = Wiki.pub.all
      if current_user
        @pwikis = Wiki.where(user_id: current_user.id, private: true) 
      end
  end
  
  def show
    @wiki = Wiki.friendly.find(params[:id])
  end

  def new
    @wiki = Wiki.new  
  end

  def create
    @wiki = Wiki.new(wiki_params)
    
    @wiki.user_id = current_user.id unless current_user ==  nil
    @wiki.private = false unless wiki_params["private"] = 1
    
    authorize @wiki
    if  @wiki.save
          flash[:notice] = "Your wiki was saved."
        redirect_to @wiki
    else
        flash[:error] = "Someting went wrong. Please try again."
      render :new
    end
  end

  def edit
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    #@collaboration = Collaboration.new
    @users = User.not_current_user(current_user)
    @users.reject! do |user| 
      @wiki.collaborations.pluck(:user_id).include? user.id or
      user.id == current_user.id
    end
    
  end

  def update
    @wiki = Wiki.friendly.find(params[:id])
    #@collaborations = Collabotation.find(@wiki.id)
    if @wiki.update_attributes(wiki_params)

      flash[:notice] = "Post was updated."
      redirect_to @wiki
    else
      flash[:error] = "Something went wrong with updating your wiki. Please try again."
      render :edit
    end
  end

  def destroy
    
    @wiki = Wiki.friendly.find(params[:id])
    authorize @wiki
    @wiki.destroy
    flash[:notice] = "Deleted successfully."
    redirect_to wikis_path
  end

private

  def wiki_params 
    params.require(:wiki).permit(:title, :body, :user_id, :private, collaborations_attributes: [collaboration: [:user_id]])

  end

end
