class RiddleSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :riddle
  set_id :id

  attributes :title, :visible_from, :sponsor

  attributes :content do |object|
    object['content'] if object['visible_from'] < Time.current
  end

  attributes :answer do |object|
    object['answer'] if object['visible_from'] < Time.current - 2.hours
  end
end
