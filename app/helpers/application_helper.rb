# frozen_string_literal: true

module ApplicationHelper
  def database_exists?
    ::ActiveRecord::Base.connection_pool.with_connection(&:active?)
  rescue StandardError
    false
  end

  def db_table_exists?(table)
    ::ActiveRecord::Base.connection.table_exists?(table)
  end
end
