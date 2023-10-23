# ==============================================================================
# Configures CarrierWave to use MinIO as the storage service
# ------------------------------------------------------------------------------
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     Rails.application.credentials.dig(:minio, :aws_access_key_id),
    aws_secret_access_key: Rails.application.credentials.dig(:minio, :aws_secret_access_key),
    host:                  Rails.application.credentials.dig(:minio, :host),
    endpoint:              Rails.application.credentials.dig(:minio, :endpoint),
    path_style:            true
  }
  config.fog_directory  = Rails.application.credentials.dig(:minio, :fog_directory)
  config.fog_public     = false
  config.fog_attributes = { 'Cache-Control' => "max-age=#{365.days.to_i}" }
end
