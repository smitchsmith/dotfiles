require_relative '04_associatable'

# Phase V
module Associatable

  def has_one_through(name, through_name, source_name)
    _assoc_options = assoc_options

    define_method(name) do
      through_options = _assoc_options[through_name.to_sym]
      source_options = through_options.model_class.assoc_options[source_name.to_sym]

      search_value = self.send(through_options.foreign_key)

      sql = <<-SQL
        SELECT #{source_options.table_name}.*
        FROM #{through_options.table_name}
        JOIN #{source_options.table_name} ON #{source_options.table_name}.#{source_options.primary_key} = #{through_options.table_name}.#{source_options.foreign_key}
        WHERE #{through_options.table_name}.#{through_options.primary_key} = ?
      SQL

      source_options.model_class.parse_all(DBConnection.execute(sql, search_value)).first
    end
  end

end