class PhotoService
  attr_reader :results

  def initialize(user:, params:)
    @user = user
    @params = params
  end

  SORT_OPTIONS_METATAGS = [].freeze

  def call
    select_photos
  end

  private

  def select_photos
    query = PhotoQuery.new(initial_scope: @user.photos,
                           query: @params[:query],
                           order: order,
                           page: @params[:page] || 1)

    @results = query.call
  end

  SORT_AVAILABLE_FIELDS = SORT_OPTIONS_METATAGS.map { |option| option[:field] }

  def order
    sort_param = @params[:sort]
    return sort_param if sort_param&.in?(SORT_AVAILABLE_FIELDS)
  end
end
