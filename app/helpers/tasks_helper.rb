module TasksHelper
  def show_japanese_choices(columns, column)
    columns.keys.map { |k| [I18n.t("enums.task.#{column}.#{k}"), k] }
  end
end
