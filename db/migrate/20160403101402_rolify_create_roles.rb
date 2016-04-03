class RolifyCreateRoles < ActiveRecord::Migration
  def change
    change_table(:roles) do |t|
      t.references :resource, :polymorphic => true
    end

    create_table(:users_roles, :id => false) do |t|
      t.references :user
      t.references :role
    end

    add_index(:roles, :name)
    add_index(:roles, [ :name, :resource_type, :resource_id ])
    add_index(:users_roles, [ :user_id, :role_id ])
  end
end
