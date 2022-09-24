class UserBulkService < ApplicationService
  attr_reader :archive

  def initialize(archive_param)
    @archive = archive_param.tempfile
  end

  def call
    Zip::File.open(@archive) do |zip_file|
      zip_file.glob('*.xlsx').each do |entry|
        User.import(users_from(entry), ignore: true)
      end
    end
  end

  private

  def users_from(entry)
    sheet = RubyXL::Parser.parse_buffer(entry.get_input_stream.read)[0]
    sheet.map do |row|
      cells = row.cells[0..3].map { |c| c&.value.to_s }
      User.new(name: cells[0],
               nickname: cells[1],
               email: cells[2],
               password: cells[3],
               password_confirmation: cells[3])
    end
  end
end
