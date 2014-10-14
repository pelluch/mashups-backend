# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :facebook, '304090573130128', 'e9dde398991aa6725948313b1c308fb1'

# end

if Rails.env == 'development' || Rails.env == 'test'
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, '304090573130128', 'e9dde398991aa6725948313b1c308fb1'
  end
else
  # Production
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, 'PRODUCTION_APP_ID', 'PRODUCTION_APP_SECRET'
  end
end