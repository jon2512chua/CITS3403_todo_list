# == Schema Information
#
# Table name: todos
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  due_date   :date
#  completed  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end