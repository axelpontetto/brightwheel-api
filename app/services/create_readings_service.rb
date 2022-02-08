class CreateReadingsService
  def initialize(args)
    @uuid = args[:uuid]
    @readings_params = args[:readings]
  end

  def call
    @device = Device.find_or_create_by!(uuid: uuid)
    @readings = @device.readings.create!(new_readings_params)
    [@device, @readings]
  end

  private

  attr_reader :uuid, :readings_params

  def new_readings_params
    readings_params.select { |rp| !@device.readings.exists?(timestamp: rp[:timestamp], count: rp[:count]) }
  end
end
