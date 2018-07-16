module RequestsHelper
  def self.requests_for_select
    { "Pendientes" => "0", "Aceptadas" => "1", "Rechazadas" => "2", "Canceladas" => "3" }
  end
end
