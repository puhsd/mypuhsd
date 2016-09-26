desc "Process password import"
task :import_vendor_info => :environment do
  u = Upload.find(ENV["UPLOAD_ID"])
  u.uploadPasswords
end
