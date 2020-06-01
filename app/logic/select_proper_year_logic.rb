class SelectProperYearLogic
  def self.year
    current_date = Date.today

    if current_date.month < 7
      current_date.year
    else
      current_date.year + 1
    end
  end
end
