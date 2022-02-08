module Api
  module V1
    class DevicesController < ApiController
      def show
        @device = Device.find_by!(uuid: params[:id]).decorate
      end
    end
  end
end
