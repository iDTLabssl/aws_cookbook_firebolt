include_recipe "firebolt"

# Search apps to be deployed. Without deploy:true filter all apps would be returned.
apps = search(:aws_opsworks_app, "deploy:true") rescue []
Chef::Log.info "About to deploy apps"

rds_db_instance = search("aws_opsworks_rds_db_instance").first
Chef::Log.info("********** The RDS instance's address is '#{rds_db_instance['address']}' **********")
Chef::Log.info("********** The RDS instance's password is '#{rds_db_instance['db_password']}' **********")
Chef::Log.info("********** The RDS instance's user is '#{rds_db_instance['db_user']}' **********")
end

apps.each do |app|

  supervisor_service "firebolt" do
    command "java -Daws.accessKeyId=#{node[:firebolt][:aws_access_key_id]} -Daws.secretKey=#{node[:firebolt][:aws_secret_access_key]} -Dlogging.path=/home/#{node[:firebolt][:user]}/logs -Dsentry.dsn=#{node[:firebolt][:sentry_dsn]} -Dkannel.url=#{node[:firebolt][:kannel_url]} -Dkannel.port=#{node[:firebolt][:kannel_port]} -Dkannel.username=#{node[:firebolt][:kannel_username]} -Dkannel.password=#{node[:firebolt][:kannel_password]}-DAfricell=#{node[:firebolt][:africell_smsCentreNumber]} -DAirtel=#{node[:firebolt][:airtel_smsCentreNumber]} -Dadmin.username=#{node[:firebolt][:admin_username]} -Dadmin.password=#{node[:firebolt][:admin_password]} -jar firebolt.jar"
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
