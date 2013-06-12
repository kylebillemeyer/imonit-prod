class PositiveNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.nil? || value < 0
      record.errors[attribute] << (options[:message] || "must be zero or more.")
    end
  end
end