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
    tuning = Audio::Tuning::Engine.tuneByInfo(tuningInfo: info)
    assert_equal  55.3, tuning["A1"].round(1)
    assert_equal 110.5, tuning["A2"].round(1)
    assert_equal 221.0, tuning["A3"].round(1)
    assert_equal 442.0, tuning["A4"].round(1)
  end

  def test_pure_major
    info   = Audio::Tuning::Info.new(442, "pureMajor", "C", "C")
    tuning = Audio::Tuning::Engine.tuneByInfo(tuningInfo: info)
    assert_equal  54.8, tuning["A1"].round(1)
    assert_equal 109.5, tuning["A2"].round(1)
    assert_equal 219.0, tuning["A3"].round(1)
    assert_equal 438.0, tuning["A4"].round(1)
  end

  def test_pure_minor
    info   = Audio::Tuning::Info.new(442, "pureMinor", "C", "C")
    tuning = Audio::Tuning::Engine.tuneByInfo(tuningInfo: info)
    assert_equal  54.8, tuning["A1"].round(1)
    assert_equal 109.5, tuning["A2"].round(1)
    assert_equal 219.0, tuning["A3"].round(1)
    assert_equal 438.0, tuning["A4"].round(1)
  end

end
