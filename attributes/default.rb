# make sure we get the correct version of java installed
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['set_etc_environment'] = true
default['java']['oracle']['accept_oracle_download_terms'] = true

default['firebolt']['user'] = 'ubuntu'
default['firebolt']['group'] = 'ubuntu'

default[:firebolt][:version] = '0.0.1'
default[:firebolt][:file] = "firebolt-#{default[:firebolt][:version]}.jar"
default[:firebolt][:profile] = 'development'

default[:firebolt][:aws_access_key_id] = 'development'
default[:firebolt][:aws_secret_access_key] = 'development'
default[:firebolt][:sentry_dsn] = 'development'
default[:firebolt][:datadog_apikey] = 'development'

default[:project_name] = 'firebolt'
default[:project_url] = 'firebolt.io'
