module UsersHelper
  require 'set'
  def requests_for_select
    current_user.requests.collect { |r| [r.estado, r.state] }.to_set
  end

end
