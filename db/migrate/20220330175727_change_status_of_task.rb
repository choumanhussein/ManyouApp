class ChangeStatusOfTask < ActiveRecord::Migration[6.0]
  def up
   change_column :tasks, :status, :string, default: 'pending'
 end

 def down
   change_column :tasks, :status, :string
 end
end
