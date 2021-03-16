class CreatorsController < ActionController::Base
  skip_before_action :verify_authenticity_token
  def index
      @creators = Creator.all

      # when entering offset or limit in postman please enter an integer

      @creators = @creators.offset(params[:offset]) if params[:offset].present?
      @creators = @creators.limit(params[:limit ]) if params[:limit ].present?

      # when entering sort key in postman please use one of Creator model's attributes
      # when entering sort_direction key please use asc or desc

      if params[:sort].present? && params[:sort_direction].nil?
        @creators = @creators.order("#{params[:sort]}")
      elsif params[:sort].nil? && params[:sort_direction].present?
        @creators = @creators.order("#{params[:sort_direction]}")
      elsif params[:sort].present? && params[:sort_direction].present?
        @creators = @creators.order("#{params[:sort]} #{params[:sort_direction]}")
      end
      render json: { status: 200, message: 'Loaded all Creators', "dataList": @creators }, status: :ok
    end
    
    def show
      @creator = Creator.find(params[:id])
      render json: { status: 200, message: 'Loaded Selected Creator', data: @creator }, status: :ok
    end
  
    def create
      @creator = Creator.new(creator_params)
      if @creator.save
        render json: { status: 200, message: 'Creator Save', data: @creator }, status: :ok
      else
        render json: { status: 422, message: 'Creator not Saved' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def creator_params
      params.permit(:first_name, :last_name)
    end
end
