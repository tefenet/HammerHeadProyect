json.extract! viaje, :id, :origen, :destino, :fecha, :hora, :precio, :duracion, :descripcion, :created_at, :updated_at
json.url viaje_url(viaje, format: :json)
