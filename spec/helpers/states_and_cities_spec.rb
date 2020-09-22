require 'rails_helper'

RSpec.describe "Application helper methods" do
  describe 'CS.states' do
    it "it validates US States" do
      state = "Georgia"
      bad_state = "Mongolia"
      expect(CS.states(:us).invert.include?(state)).to be(true)
      expect(CS.states(:us).invert.include?(bad_state)).to be(false)     
    end
  end
  describe 'CS.cities' do
    it "it validates cities within a given state" do
      state = "GA"
      city = "Atlanta"
      bad_city = "Sin City"
      expect(CS.cities(state.to_sym, :us).include?(city)).to be(true)
      expect(CS.cities(state.to_sym, :us).include?(bad_city)).to be(false)    
    end
  end
end