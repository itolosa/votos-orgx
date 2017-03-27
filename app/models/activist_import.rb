class ActivistImport
  include ActiveModel::Model

  attr_accessor :file

  def save
    if imported_activists.map(&:valid?).all?
      imported_activists.each(&:save!)
      true
    else
      imported_activists.each_with_index do |activist, index|
        activist.errors.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: message"
        end
      end
      false
    end
  end

  def imported_activists
    @imported_activists ||= load_imported_activists
  end

  def load_imported_activists
    spreadsheet = open_spreadsheet
    header = spreadsheet.row(1).map(&:downcase)
    (2..spreadsheet.last_row).map do |i|
      row = Hash[[header, spreadsheet.row(i).map(&:strip)].transpose]
      row['section'] = row['section'].titleize
      row['name'] = row['name'].titleize
      row['email'].downcase!
      section = Section.find_or_create_by(name: row['section'])
      fronts = row['fronts'].split('/').map do |front|
        Front.find_or_create_by(name: front.strip.titleize)
      end
      activist = Activist.find_by_email(row['email']) || Activist.new
      activist.attributes = row.to_hash.slice(*Activist.accessible_attributes)
      activist.section = section
      activist.fronts = fronts
      activist.fill_pass unless activist.persisted?
      activist
    end
  end

  def open_spreadsheet
    case File.extname(file.original_filename)
    when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
    when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
