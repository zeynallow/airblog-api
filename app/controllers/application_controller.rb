class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

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

  def render_not_found_response(invalid)
    render json: { success: false, message: 'Not found' }, status: :not_found
  end

  def render_unprocessable_entity_response(invalid)
    render json: { success: false, errors: invalid.record.errors.full_messages, message: 'Unprocessable entity' }, status: :unprocessable_entity
  end

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      total_pages: collection.total_pages,
      total_entries: collection.total_entries
    }
  end

end