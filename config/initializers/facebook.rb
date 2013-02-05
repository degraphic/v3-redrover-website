#-----------------------------------------------------------------------------79
# Facebook initialization
#-------------------------------------------------------------------------------
config_yaml = YAML::load(ERB.new(File.read(Rails.root.join('config', 'facebook.yml'))).result)[Rails.env.to_s]

config = OpenStruct.new({
  :id => config_yaml['app_id'],
  :secret => config_yaml['app_secret']
})

V3RedroverWebsite::Application.config.facebook = config