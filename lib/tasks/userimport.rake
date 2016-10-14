desc "Process User LDAP import"
task :import_user_from_ldap => :environment do
  User.import_from_ldap
  
end
