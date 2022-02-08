module Api
  module V1
    class ReadingsController < ApiController
      def create
        @device, @readings = CreateReadingsService.new(readings_params).call
      end

      private

      def readings_params
        params.permit(:uuid, readings: [[:count, :timestamp]])
      end
    end
  end
end
