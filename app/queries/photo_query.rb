class PhotoQuery
  def initialize(initial_scope: Photo.all, query:, order:, page:)
    @initial_scope = initial_scope
    @query = query
    @order = order
    @page = page
  end

  def call
    collection = @initial_scope
    collection.order(order, created_at: :desc).page(@page)
  end

  private

  DEFAULT_SORT = 'photos.created_at DESC'.freeze

  def order
    @order ? data_ordering : DEFAULT_SORT
  end

  def data_ordering
    @order.starts_with?('-') ? "#{@order[1..-1]} DESC NULLS LAST" : @order
  end
end
