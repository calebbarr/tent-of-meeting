require 'test_helper'

class ChatCellTest < Cell::TestCase
  test "show" do
    invoke :show
    assert_select "p"
  end
  

end
