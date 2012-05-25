require 'test_helper'

class FlightTest < ActiveSupport::TestCase
  
  test "the distance is calculated correctly" do
    f = Flight.new(:departure_airport_code => 'ORD', :arrival_airport_code => 'BOS')
    f.calculate_distance
    assert_equal 866, f.distance
  end

  test "the distance is calculated automatically when the flight is saved" do
    f = Flight.create(:departure_airport_code => 'ORD', :arrival_airport_code => 'BOS')
    assert_equal 866, f.distance
  end
  
  test "a flight knows when it will arrive" do
    f = Flight.new(:departure_airport_code => 'ORD', :arrival_airport_code => 'BOS')
    f.departs_at = (Date.today + 8.hours)
    expected_duration = (866 / 8.0).round
    assert_equal (f.departs_at + expected_duration.minutes), f.arrives_at
  end
  
end







