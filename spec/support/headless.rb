RSpec.configure do |config|
  config.before(:suite) do
    # Use the headless gem to manage your Xvfb server
    # Do not destroy X server incase another process is using it
    Headless.new(:destroy_on_exit => false).start
  end
end
