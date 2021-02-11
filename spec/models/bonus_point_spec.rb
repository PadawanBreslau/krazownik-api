require 'rails_helper'

RSpec.describe BonusPoint do
  it 'dissalows to close' do
    event = create(:event)
    lat = 0.0
    lon = 20.0
    create(:bonus_point, event: event, lat: lat, lon: lon)
    expect { create(:bonus_point, event: event, lat: lat, lon: lon) }
      .to raise_error(ActiveRecord::RecordInvalid)
      .with_message('Validation failed: Lat Point already defined in this area')
  end

  it 'allows to edit' do
    point = create(:bonus_point)
    expect { point.update(name: 'Skała') }.not_to raise_error
  end
end
