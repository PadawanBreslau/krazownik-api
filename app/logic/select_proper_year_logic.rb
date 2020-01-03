class SelectProperYearLogic
  def call
    current_date = Date.today

    if current_date.month < 6
      current_date.year
    else
      current_date.year + 1
    end
  end
end
