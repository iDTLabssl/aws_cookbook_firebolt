include_recipe "firebolt"

# Search apps to be deployed. Without deploy:true filter all apps would be returned.
apps = search(:aws_opsworks_app, "deploy:true") rescue []
Chef::Log.info "About to deploy apps"


apps.each do |app|

  supervisor_service "firebolt" do
    command "java -Daws.accessKeyId=#{node[:firebolt][:aws_access_key_id]} -Daws.secretKey=#{node[:firebolt][:aws_secret_access_key]} -Dlogging.path=/home/#{node[:firebolt][:user]}/logs -Dsentry.dsn=#{node[:firebolt][:sentry_dsn]} -jar firebolt.jar"
    directory "/home/#{node[:firebolt][:user]}"
    user node[:firebolt][:user]
    autostart true
    autorestart true
    environment :HOME => "/home/#{node[:firebolt][:user]}"
  end

  supervisor_service "firebolt" do
    action :stop
  end

  aws_s3_file "/home/#{node[:firebolt][:user]}/firebolt.jar" do
    bucket 'sms-firebolt'
    remote_path "#{node[:firebolt][:file]}"
    region 'eu-west-1'
    aws_access_key_id "#{node[:firebolt][:aws_access_key_id]}"
    aws_secret_access_key "#{node[:firebolt][:aws_secret_access_key]}"
  end

  bash "chown_firebolt" do
    code <<-EOH
     chown ubuntu:ubuntu /home/#{node[:firebolt][:user]}/firebolt.jar;
     chmod 755 /home/#{node[:firebolt][:user]}/firebolt.jar;
    EOH
  end



  supervisor_service "firebolt" do
    action :start
  end


end
