json.device do
  json.uuid @device.uuid
  json.readings @readings, :timestamp, :count
end
