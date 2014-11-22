require 'test_helper'

class PrerequisiteTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Prerequisite.new.valid?
  end
end
