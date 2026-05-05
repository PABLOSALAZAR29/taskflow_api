module Api
  module V1
    class AuthController < BaseController
      # POST /api/v1/auth/register
      def register
        user = User.new(user_params)

        if user.save
          render json: {
            success: true,
            message: "Usuario creado exitosamente",
            user: UserBlueprint.render_as_hash(user),
            token: user.generate_jwt
          }, status: :created
        else
          render_error(
            "No se pudo crear el usuario", 
            status: :unprocessable_entity, 
            errors: user.errors.full_messages
          )
        end
      end

      # POST /api/v1/auth/login
      def login
        user = User.find_by(email: params[:email]&.downcase)

        if user&.authenticate(params[:password])
          render json: {
            success: true,
            message: "Login exitoso",
            user: UserBlueprint.render_as_hash(user),
            token: user.generate_jwt
          }
        else
          render_error("Email o contraseña incorrectos", status: :unauthorized)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end