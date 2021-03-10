module TasksHelper
  def ja_select(columns, column)
    columns.keys.map { |k| [I18n.t("enums.task.#{column}.#{k}"), k] }
  end
end
