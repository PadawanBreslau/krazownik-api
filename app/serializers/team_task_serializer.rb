class TeamTaskSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :team_task
  set_id :id

  has_many :team_task_photos

  attribute :completion do |object|
    ((object.team_task_photos.where(accepted: true).count * 100) / object.amount.to_f).round(1)
  end

  attributes :content, :description, :amount, :approved_by_leader
end
