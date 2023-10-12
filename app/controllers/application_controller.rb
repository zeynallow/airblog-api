class ApplicationController < ActionController::API

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { success: false, message: 'Unauthorized' }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { success: false, message: 'Unauthorized' }, status: :unauthorized
    end
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_entries: collection.total_entries
    }
  end

end