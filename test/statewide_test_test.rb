require_relative '../lib/enrollment_repository'
require_relative '../lib/statewide_test'
require_relative '../lib/statewide_test_repository'

require_relative '../lib/math_helper'
require_relative 'test_helper'


class StatewideTestTest < Minitest::Test


  def test_proficient_by_grade_stored_in_hash
    str = StatewideTestRepository.new

    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv"
      }
      })
      e1 = {:math=>0.697, :reading=>0.703, :writing=>0.501}
      e2 = {:math=>0.499, :reading=>0.726, :writing=>0.528}

      statewide_test = StatewideTest.new(str.statewide_tests)

      assert_equal e1, statewide_test.proficient_by_grade(3)[2008]
      assert_equal e2, statewide_test.proficient_by_grade(8)[2009]
      # assert_raise UnknownDataError, statewide_test.proficient_by_grade(7)
    end

    def test_proficient_by_grade_ethinic
      skip
      str = StatewideTestRepository.new
      str.load_data({
        :statewide_testing => {
          :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
          :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
          :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
          :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
          :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
        }
        })

        statewide_test = StatewideTest.new.statewide_test
        statewide_test = str.statewide_tests
        statewide_test.proficient_by_race_or_ethnicity(:asian)

        assert_equal [3, 8], statewide_test.class_data.keys
      end


    end
