class ChangeColumnsOnTask < ActiveRecord::Migration[6.0]
  def change
    change_column_null :tasks, :title, false
  end
  def change
   change_column_null :tasks, :status, false
 end
 def change
   change_column_null :tasks, :priority, false
 end
end
