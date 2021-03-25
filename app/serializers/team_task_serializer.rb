class TeamTaskSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :team_task
  set_id :id

  has_many :team_task_photos

  attribute :content, :description, :amount, :approved_by_leader
end
