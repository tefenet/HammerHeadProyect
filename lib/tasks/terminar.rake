namespace :terminar do
  desc "TODO"
  task viaje1: :environment do
  	(Viaje.find(1)).generarPuntajesChofer
  end

end
