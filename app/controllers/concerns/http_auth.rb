module HttpAuth
  extend ActiveSupport::Concern

  included do
    before_action :http_auth, except: %i[index show]
  end

  private

  def http_auth
    # return true if Rails.env == 'development'

    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.dig(:http_auth, :name).to_s &&
        password == Rails.application.credentials.dig(:http_auth, :pass).to_s
    end
  end
end
