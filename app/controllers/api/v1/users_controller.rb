module Api
  module V1
    class UsersController < BaseController
      # Antes de ejecutar cualquier acción, verificamos autenticación
      before_action :authenticate_request!

      # GET /api/v1/profile
      def show
        render_success({
          user: UserBlueprint.render_as_hash(current_user, view: :normal)
        })
      end
    end
  end
end