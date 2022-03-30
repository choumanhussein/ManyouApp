class ChangePriorityOfTask < ActiveRecord::Migration[6.0]
  def up
   change_column :tasks, :priority, :integer, default: '0'
 end

 def down
   change_column :tasks, :priority, :integer
 end
end
