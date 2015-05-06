module MarathonsHelper
  def add_zero_lambda
    ->(s) { s.rjust(2, '0') }
  end
end
