module SearchHelper

def validarRango(rango)
  return if rango.end.blank? || rango.begin.blank?

  if rango.end < rango.begin
    return false
  else
    return true
  end
end

  def self.fechaDePago(viaje)
    if viaje.pasajeros.include?User.current
    viaje.startT
    else
    viaje.finishT
    end
  end

  def formatDate(fecha)
  textYear,textMonth,textDay=fecha[:q].split('-');
  s=Date.new(textYear.to_i,textMonth.to_i,textDay.to_i)
  textYear,textMonth,textDay=fecha[:m].split('-');
  f=Date.new(textYear.to_i,textMonth.to_i,textDay.to_i)
  (s..f)
  end

  def self.viajesdeUser(user)
    Viaje.all.select{|v| v.pasajeros.include?user}
  end

  def self.request_filter(selectedState)
    Request.all.select{|r| r.viaje.chofer.id==User.current.id && r.state.to_i==selectedState.to_i}
  end

  def self.request_pas_filter(selectedState)
    User.current.requests.select{|r| r.state.to_i==selectedState.to_i}
  end

  def self.req_All
    Request.all.select{|r| r.viaje.chofer.id==User.current.id}
  end
end
