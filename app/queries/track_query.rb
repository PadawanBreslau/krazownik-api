class TrackQuery
  def initialize(initial_scope: Track, query:, order:, page:)
    @initial_scope = initial_scope
    @query = query
    @order = order
    @page = page
  end

  #   WHERE_CONDITION = <<-SQL.squish.freeze
  #     LOWER(candidates.data->>'name') LIKE :query
  #     OR LOWER(candidates.data->>'first_name') LIKE :query
  #     OR LOWER(candidates.data->>'last_name') LIKE :query
  #     OR LOWER(candidates.data->>'email') LIKE :query
  #     OR LOWER(messages.message_content) LIKE :query
  #     OR LOWER(positions.title) LIKE :query
  #     OR LOWER(users.name) LIKE :query
  #     OR LOWER(users.email) LIKE :query
  #     OR messages.salary_offer_top::VARCHAR LIKE :query
  #     OR messages.salary_offer_bottom::VARCHAR LIKE :query
  #   SQL

  def call
    collection = TrackFile.all
    collection.order(order, created_at: :desc).page(@page)
  end

  private

  DEFAULT_SORT = 'track_files.created_at DESC'.freeze

  def order
    @order ? data_ordering : DEFAULT_SORT
  end

  def data_ordering
    @order.starts_with?('-') ? "#{@order[1..-1]} DESC NULLS LAST" : @order
  end
end
