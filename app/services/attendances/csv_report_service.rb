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
          csv << [
            data['employee_name'], Date.parse(data['attendance_date']).strftime('%d-%m-%Y'),
            data['is_present'] ? TICK_MARK : '', data['is_absent'] ? CROSS_MARK : ''
          ]
        end
        csv << ['', '', '', '', '', '', '']
        csv << ['Employee Name', 'Total Present', 'Total Absent']
        parsed_response.group_by { |record| record['user_id'] }.each do |user_id, records|
          csv << [records.first['employee_name'], total_presents(records), total_absents(records)]
        end
      end
    end

    private

    attr_reader :attendances

    def total_presents(attendance_records)
      attendance_records.count { |record| record['is_present'] == true }
    end

    def total_absents(attendance_records)
      attendance_records.count { |record| record['is_absent'] == true }
    end

  end
end