class DeviceDecorator < Draper::Decorator
  delegate_all

  def cumulative
    @object.readings.sum(:count)
  end

  def most_recent_reading
    @object.readings.order(timestamp: :desc).first
  end
end
