module PublicShow
  extend ActiveSupport::Concern
  included do
    skip_before_action :authenticate_user!, only: [:show]
  end
end
