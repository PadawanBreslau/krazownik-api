class CreateResultService
  def initialize(participation:, result:, total:)
    @participation = participation
    @result = result
    @total = total
  end

  def call
    save_result
  end

  private

  def save_result
    Result.create(participation: @participation, result: @result, total: @total)
  end
end
