class RenameColumnTypeToHistoricTypeFromHistoricals < ActiveRecord::Migration
  def change
    rename_column :historicals, :type, :historic_type
  end
end
