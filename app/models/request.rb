class Request < ApplicationRecord
  belongs_to :user
  belongs_to :viaje
  validate :pending_Score, on:[:create]
  validate :tarjeta
  validate :vencimiento
  before_create :iniciar

  def iniciar
    self.state||=0
    self.passengerScore||=0
    self.driverScore||=0
  end

  def pending_Score
    if User.current.pending_califications
      errors.add(:base, 'tienes puntuaciones pendientes')
    end
  end

  def puntajeChoferPendiente
    self.state==1 && self.driverScore==0
  end

  def puntajePasajeroPendiente
    self.state==1 && self.passengerScore==0
  end

  def tarjeta
    unless User.current.has_credit_card
      errors.add(:base, 'debes registrar tu tarjeta de credito')
    end
  end

  def vencimiento
    unless User.current.can_Pay(viaje)
      errors.add(:base, 'tu tarjeta de credito caduca antes del viaje')
    end
  end

  def estado
    if state==0
      m="pendiente"
    else
      if state==1
        m="aceptada"
      else
        if state==2
          m="rechazada"
        else
          m = "cancelada"
        end
      end
    end
  m
  end

  def isPending
    state == 0
  end

  def isAccepted
    state == 1
  end

  def isRefused
    state == 2
  end

  def isCanceled
    state == 3
  end

  def cancel(usuario)
    viaje.removePasajero(user)
    if usuario=self.user
      self.update_columns(:passengerScore=>-1,:state=>3)
    else
      self.update_columns(:driverScore=>-1,:state=>3)
    end
  end

  def change(code)
    case code
    when 1
      self.accept
    when 2
      self.refuse
    when 3
      self.cancel(User.current)
    end
  end

  def accept
    if viaje.asientos_libres>0 && user.can_Travel(viaje_id)
      if self.update(:state=>1)
        self.viaje.add_Pasajero(self.user)
      end
    elsif viaje.asientos_libres == 0
      errors.add(:base,'no puedes aceptar este pasajero porque no hay mas lugar en tu vehiculo')
    else
      errors.add(:base,'no puedes aceptar este pasajero porque tiene otro viaje')
    end
  end

  def refuse
    self.update_column(:state,2)
  end
end
