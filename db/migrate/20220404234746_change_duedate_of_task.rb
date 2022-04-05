class ChangeDuedateOfTask < ActiveRecord::Migration[6.0]
  def change
     change_column_null :tasks, :duedate, false
  end
end
