module ApplicationHelper
  def us_states
    CS.states(:us).invert
  end

  def us_cities
    CS.cities(:state, :us)
  end
end