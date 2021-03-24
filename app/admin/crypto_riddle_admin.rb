Trestle.resource(:crypto_riddle, model: CryptoRiddle) do
  scope :all
  scope :current, default: true

  menu do
    group :crypto do
      item :crypto_riddle, icon: 'fa fa-clock-o'
    end
  end

  active_storage_fields do
    [:image]
  end


  form do
    row do 
      col { select :crypto_challenge_id, CryptoChallenge.all.map{|cc| [cc.year, cc.id]} }
      col { text_field :solution } 
    end

    row do
      active_storage_field :image
    end
  end
end

