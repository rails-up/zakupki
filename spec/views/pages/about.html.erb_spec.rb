require 'rails_helper'

RSpec.describe "pages/about.html.erb", type: :view do

  it "have content Этапы проведения СП" do
    render
    expect(response.body).to match("Этапы проведения СП")
  end

end
