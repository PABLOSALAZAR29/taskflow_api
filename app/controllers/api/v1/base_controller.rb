module Api
  module V1
    class BaseController < ActionController::API
      # Método para obtener el usuario actual
      def current_user
        @current_user ||= authenticate_user!
      end

      # Autenticación vía JWT
      def authenticate_user!
        header = request.headers['Authorization']
        token = header&.split(' ')&.last

        return nil if token.blank?

        begin
          decoded = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
          user_id = decoded.first['user_id']
          User.find_by(id: user_id)
        rescue JWT::ExpiredSignature
          nil
        rescue JWT::DecodeError
          nil
        end
      end

      # Método para requerir autenticación
      def authenticate_request!
        unless current_user
          render_error("Necesitas estar autenticado para esta acción", status: :unauthorized)
        end
      end

      # Respuestas estandarizadas
      def render_success(data, status: :ok)
        render json: { success: true, data: data }, status: status
      end

      def render_error(message, status: :bad_request, errors: nil)
        render json: {
          success: false,
          message: message,
          errors: errors
        }, status: status
      end
    end
  end
end