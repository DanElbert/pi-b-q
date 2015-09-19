json.array!(@projects) do |project|
  json.extract! project, :id, :name, :start, :end, :sensor1_name, :sensor2_name
  json.url project_url(project, format: :json)
end
