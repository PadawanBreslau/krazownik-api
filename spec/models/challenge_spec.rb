require 'rails_helper'

RSpec.describe Challenge do
  it 'attaches default icon' do
    challenge = create(:challenge)
    expect(challenge.icon.attached?).to be(true)
  end

  it 'allows to add details' do
    challenge = create(:challenge)
    locations = [{ "lat": '1', "lon": '1' }, { "lat": '2', "lon": '2' }]
    challenge.locations = locations
    expect { challenge.save }.not_to raise_error
  end

  it 'raises error if locations are corrupted' do
    challenge = create(:challenge)
    locations = [{ "lat": '1' }, { "lat": '2' }]
    challenge.locations = locations
    expect { challenge.save! }.to raise_error(ActiveRecord::RecordInvalid)
    locations = [{}]
    challenge.locations = locations
    expect { challenge.save! }.to raise_error(ActiveRecord::RecordInvalid)
    locations = [{ "tet": '1' }, { "tet": '2' }]
    challenge.locations = locations
    expect { challenge.save! }.to raise_error(ActiveRecord::RecordInvalid)
    locations = [{ "lat": '1', "lon": '1', "tet": '1' }, { "lat": '2', "lon": '2', "tet": '1' }]
    challenge.locations = locations
    expect { challenge.save! }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
