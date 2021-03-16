class GigsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def index
      @gigs = Gig.all
      # please use brand_name or creator_id as key names. brand name is a string and creator_id is an integer
      @gigs = Gig.where(brand_name: params[:brand_name] )if params[:brand_name].present? 
      if params[:creator_id].present? 
        @creator = Creator.find(params[:creator_id])
        @gigs =  @creator.gigs
      end 
      render json: { status: 200, message: 'Loaded all gigs', "dataList": @gigs }, status: :ok
    end
    
    def show
      @gig = Gig.where(id: params[:id])
      # for creator key and gig_payment key anything can be put there to make this work, I just used the boolean true
      @gig = (@gig + [@gig.first.creator]) if params[:creator].present?
      @gig = (@gig + [@gig.first.gig_payment]) if params[:gig_payment].present?
      render json: { status: 200, message: 'Loaded Selected gig', data: @gig }, status: :ok
    end
  
    def create
      @gig = Gig.new(gig_params)
      # brand_name and collector_id are required
      @gig.update_attribute(:state, 0)
      if @gig.save
        render json: { status: 200, message: 'gig Saved', data: @gig }, status: :ok
      else
        render json: { status: 422, message: 'gig not Saved' }, status: :unprocessable_entity
      end
    end
  
    def update
      @gig = Gig.find(params[:id])
      @gig.update_attribute(:brand_name, params[:brand_name] ) if params[:brand_name].present?
      @gig.update_attribute(:state,  params[:state].to_i ) if params[:state].present?
      @gig.update_attribute(:creator_id, params[:creator_id] ) if params[:creator_id].present?
      render json: { status: 200, message: 'gig Updated', data: @gig }, status: :ok
    end

    private
  
    def gig_params
      params.permit(:brand_name, :state, :creator_id)
    end
end
