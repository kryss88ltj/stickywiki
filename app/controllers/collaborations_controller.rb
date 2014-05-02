class CollaborationsController < ApplicationController
  
  def new 
    @collaboration = Collaboration.new
  end

  def create
    @wiki = Wiki.friendly.find(params[:id])
    @collaboration = Collaboration.new(user_id: params[:user_id], wiki_id:  @wiki.id)
    
    if @collaboration.save
      redirect_to wikis_path, notice: "Wiki shared."
    else
      flash[:error] = "Error creating wiki. Try again."
      render :new
    end
  end

  def show
    @collaboration = Collaboration.find(params[:wiki])
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id]) 
    @collaboration = Collaboration.find(params[:id])
    @collaboration.destroy
    flash[:notice] = "Collaboration successfully deleted."
    redirect_to wikis_path
  end


private

 def collab_params
       params.require(:collaboration).permit(:user_id, :wiki_id)
 end

 end
