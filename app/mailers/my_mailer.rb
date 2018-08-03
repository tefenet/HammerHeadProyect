class MyMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views
  default from: 'viajesaventon@yandex.com'
  def announce(muzzarellaDoble)
    @salchichónAhumado=muzzarellaDoble.user
    @birra=muzzarellaDoble.viaje
    @lechugafrescaParami_queNomegustalaPizza=muzzarellaDoble.nil?#esto esta puesto porque si, porque llevo una semana sentado con esta winchila
    mail(:to => @salchichónAhumado.email , subject: 'tu solicitud fue aceptada')
  end

  def unaFugazza(pistola)
    @unchabón=pistola.user
    @quebuen_cafe_tienenEn_la_bastilla=pistola.viaje
    mail(:to => @unchabón.email , subject: 'tu solicitud fue cancelada')
  end

  def nueva_Solicitud(coso)
    @viaje=coso.viaje
    mail(:to => @viaje.chofer.email , subject: 'tienes una nueva solicitud')
  end

  def pasajero_cancela(req)
    @viaje=req.viaje
    @pasajero=req.user
    mail(:to => @viaje.chofer.email , subject: 'solicitud cancelada')
  end

  def viajeBaja(pasajero , viaje)
    @vi=viaje
    @pas=pasajero
    mail(:to => pasajero.email , subject: 'viaje cancelado')
  end
end
