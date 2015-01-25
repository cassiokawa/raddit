class LinksController < ApplicationController
 before_action :set_link, only: [:show, :edit, :update, :destroy]
 before_action :authenticate_user!, except: [:index, :show]

  # GET /links
  # GET /links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
      @link = current_user.links.build(link_params)
      if @link.save
        redirect_to @link, notice: 'Link was successfully created.'
      else
        render action: 'new'
      end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
      if @link.update(link_params)
        redirect_to @link, notice: 'Link was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    redirect_to links_url
  end

  def upvote
   @link = Link.find(params[:id])
    @link.upvote_by current_user
    redirect_to :back
  end
 
  def downvote
    @link = Link.find(params[:id])
    @link.downvote_by current_user
    redirect_to :back
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    def correct_user
      @link = current_user.links.find_by(id: params[:id])
      redirect_to links_path, notice: "Not authorized to edit this link" if @link.nil?
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url)
    end
end

