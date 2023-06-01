module Attendances
  class CsvReportService < BaseService
    def initialize(attendances)
      @attendances = attendances
    end

    def call
      require 'csv'
      parsed_response = JSON.parse(attendances)
      CSV.generate(headers: true) do |csv|
        csv << ['Employee Name', 'Date', 'Present', 'Absent']
        parsed_response.each do |data|
          keys_to_delete = %w[id created_at updated_at]
          keys_to_delete.each { |key| data.delete(key) }
          csv << [data['employee_name'], Date.parse(data['attendance_date']).strftime('%d-%m-%Y'), data['is_present'] ? 'Present' : '', data['is_absent'] ? 'Absent' : '']
        end
      end
    end

    private

    attr_reader :attendances
  end
end