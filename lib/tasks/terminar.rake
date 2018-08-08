namespace :terminar do
  desc "TODO"
  task viaje1: :environment do
  	(Viaje.find(1)).generarPuntajes
  	#(Viaje.find(2)).generarPuntajes
  	#(Viaje.find(3)).generarPuntajes
  end

end
