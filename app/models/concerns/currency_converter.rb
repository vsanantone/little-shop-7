module CurrencyConverter
  def convert_to_dollars(cents)
    (cents.to_f / 100)
  end
end