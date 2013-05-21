# http://stackoverflow.com/questions/10300326/rails-env-production-script-delayed-job-start-dir-undefined
# http://stackoverflow.com/questions/6994479/initialize-the-delayed-jobs-gem-by-starting-the-workers-on-application-start
# http://stackoverflow.com/questions/5410119/cant-start-the-delayed-jobs-process

# Options
# Delayed::Worker.destroy_failed_jobs = false
# Delayed::Worker.sleep_delay = 2
# Delayed::Worker.max_attempts = 5
# Delayed::Worker.max_run_time = 1.hour
# Delayed::Worker.delay_jobs = !Rails.env.test?

# if Rails.env.development?
#   system "RAILS_ENV=development #{Rails.root.join('script','delayed_job')} stop"
#   system "RAILS_ENV=development #{Rails.root.join('script','delayed_job')} -n 2 start"
# elsif Rails.env.production?
#  if(!File.exists?(Rails.root.join('tmp','pids', 'delayed_job.pid')))
#     system "echo \"Starting delayed_jobs...\""
#     system "./script/delayed_job start &"
#   else
#     system "echo \"delayed_jobs is running\""
#   end	
#   system "RAILS_ENV=production #{Rails.root.join('script','delayed_job')} stop"
#   system "RAILS_ENV=production #{Rails.root.join('script','delayed_job')} -n 2 start"
# end