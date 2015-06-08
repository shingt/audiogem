require 'minitest/unit'
require 'minitest/autorun'

require 'audio/tuning/engine'
require 'audio/tuning/info'

class TestTuning < Minitest::Unit::TestCase

  def setup
  end

  def teardown
  end

  def test_equal
    info   = Audio::Tuning::Info.new(442, "equal", "C", "C")
    tuning = Audio::Tuning::Engine.generateTuningByInfo(tuningInfo: info)
    assert_equal 442.0, tuning["A4"].round(1)
  end

  def test_pure_minor
    info   = Audio::Tuning::Info.new(442, "pureMinor", "C", "C")
    tuning = Audio::Tuning::Engine.generateTuningByInfo(tuningInfo: info)
    assert_equal 438.0, tuning["A4"].round(1)
  end

  def test_pure_major
    info   = Audio::Tuning::Info.new(442, "pureMinor", "C", "C")
    tuning = Audio::Tuning::Engine.generateTuningByInfo(tuningInfo: info)
    assert_equal 438.0, tuning["A4"].round(1)
  end

end
