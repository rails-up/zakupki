RSpec::Matchers.define :be_url do
  match do |actual|
    begin
      URI.parse(actual)
    rescue
      false
    end
  end
end
