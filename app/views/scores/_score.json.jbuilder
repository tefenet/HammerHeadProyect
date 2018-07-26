json.extract! score, :id, :usuario_puntuador_id, :usuario_puntuado_id, :positivo, :negativo, :neutro, :estado, :comentario, :created_at, :updated_at
json.url score_url(score, format: :json)
