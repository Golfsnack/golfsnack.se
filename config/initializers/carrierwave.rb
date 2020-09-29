CarrierWave.configure do |config|

  if Rails.env.development? || Rails.env.test?
    config.storage = :file
  else
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['DO_KEY'],
      aws_secret_access_key: ENV['DO_SECRET'],
      region: ENV['DO_REGION'],
      host: ENV['DO_HOST'],
      endpoint: ENV['DO_ENDPOINT']
    }
    config.storage = :fog
    config.fog_directory = 'bucket_name'

    config.fog_directory = ENV["DO_ASSET_SPACE"]
    config.asset_host = ENV["DO_ASSET_HOST"]
    config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" }
  end
end
