require_relative 'db_connection'
require_relative '02_sql_object'

module Searchable
  def where(params)
    where_line = params.keys.map { |k| "#{k} = ?" }.join("AND ")

    sql = <<-SQL
      SELECT #{self.table_name}.*
      FROM #{self.table_name}
      WHERE #{where_line}
    SQL

    parse_all(DBConnection.execute(sql, params.values))
  end
end

class SQLObject
  extend Searchable
end
