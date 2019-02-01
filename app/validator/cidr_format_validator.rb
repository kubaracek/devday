class CidrFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      NetAddr::IPv4Net.parse(value)
    rescue NetAddr::ValidationError
      record.errors.add(attribute, "Invalid ip '#{value}'")
    end
  end
end
