FactoryBot.define do
  factory :team_task_photo do
    team_task

    accepted { false }
  end
end
