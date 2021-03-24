class TeamTaskSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :team_tasks
  set_id :id

  attribute :content, :description, :amount, :approved_by_leader
end
