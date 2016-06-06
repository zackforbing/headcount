require './lib/enrollment'
require './test/test_helper'

class EnrollmentTest < Minitest::Test
  def test_enrollment_initialize_with_hash
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    assert_equal e.enrollment_hash, {:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}}
  end

  def test_kidergarten_truncates
    e = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})

    assert_equal e.kindergarten_participation_by_year(e.enrollment_hash), {2010 => 0.391, 2011 => 0.353, 2012 => 0.267}
  end

end