require 'test_helper'

class RelatedVersesCellCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  

end
