json.device do
  json.uuid @device.uuid
  json.cumulative @device.cumulative
  json.most_recent_reading @device.most_recent_reading, :timestamp, :count
end
