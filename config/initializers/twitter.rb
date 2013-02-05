#-----------------------------------------------------------------------------79
# Twitter initialization
#-------------------------------------------------------------------------------
config_yaml = YAML::load(ERB.new(File.read(Rails.root.join('config', 'twitter.yml'))).result)[Rails.env.to_s]

config = OpenStruct.new({
  :id => config_yaml['app_id'],
})

V3RedroverWebsite::Application.config.twitter = config