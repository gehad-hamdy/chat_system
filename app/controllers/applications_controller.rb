class ApplicationsController < ApplicationController
  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameter

  # GET /applications
  # GET /applications.json
  def index
    @applications = Application.find
    render json: {data: @applications}, only: [:name]
  end

  # GET /applications/1
  def show
    verify_application_token or return

    $redis = Redis.current
    key = "application_show_" + "#{params[:application_token]}/"
    if $redis.exists(key) != 0
      @application = JSON.parse($redis.get(key))
    else
      @application = Application.find(params[:id])
      $redis.set(key, @application.to_json)
    end

    if @application
      render json: {data: @application, notice: 'fetch successfully'}, status: :ok
    else
      render json: {data: @application.errors, notice: 'error fetch data'}, status: :not_found
    end
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(name: application_params[:name], identifier_token: Application.create_identifier_token)
    if @application.save
      render json: {data: @application, notice: 'Application was successfully created.'}
    else
      render status: :unprocessable_entity, json: {notice:  'can not creat application'}
    end
  end

  # PATCH/PUT /applications/1
  def update
    verify_application_token or return
    @application = Application.find(params[:id])
    if @application.update(application_params)
      render json: {data: @application, notice: 'Application was successfully Updated.'}
    else
      render status: :unprocessable_entity, json: {notice:  'can not update application'}
    end
  end

  # DELETE /applications/1
  def destroy
    # @application.destroy
    # render applications_url, notice: 'Application was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def application_params
      params.require(:application).permit(:name)
    end

  def verify_application_token
    @application = Application.find_by_identifier_token(params[:application_token])
    handle_not_found_status and return false unless @application
    true
  end

  def handle_not_found_status
    render status: :not_found, json: {'msg' => "no application was found for this identifier token"}
  end

  def handle_missing_parameter(exception)
    render status: :bad_request, json: {'msg' => exception.message}
  end
end
