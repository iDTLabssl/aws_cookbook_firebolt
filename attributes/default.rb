# make sure we get the correct version of java installed
default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '8'
default['java']['set_etc_environment'] = true
default['java']['oracle']['accept_oracle_download_terms'] = true

default['firebolt']['user'] = 'ubuntu'
default['firebolt']['group'] = 'ubuntu'

default[:firebolt][:version] = '0.0.1'
default[:firebolt][:file] = "firebolt.jar"
default[:firebolt][:profile] = 'development'

default[:firebolt][:aws_access_key_id] = 'development'
default[:firebolt][:aws_secret_access_key] = 'development'
default[:firebolt][:sentry_dsn] = 'development'
default[:firebolt][:kannel_url] = 'url'
default[:firebolt][:kannel_port] = '000'
default[:firebolt][:kannel_username] = 'user'
default[:firebolt][:kannel_password] = 'password'
default[:firebolt][:admin_username] = 'admin'
default[:firebolt][:admin_password] = 'password'
default[:firebolt][:database_url] = 'default'
default[:firebolt][:database_username] = 'user'
default[:firebolt][:database_password] = 'password'
default[:project_name] = 'firebolt'
default[:project_url] = 'firebolt.io'
