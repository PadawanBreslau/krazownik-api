class AddPrivacyPolicyAcceptedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :privacy_policy_accepted, :boolean, default: false
  end
end
