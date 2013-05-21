# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

#every 1.day, :at => '10:00am' do
every 1.day, :at => '1:47pm' do # localhost time: GMT+0
  runner "User.send_reminder"
end

# every 1.day, :at => '9:47pm' do
#   runner "User.send_reminder"
# end

# every 1.minute do
#   runner "User.send_reminder"
# end

# FOR SCHEDULER TO RUN IN DEVELOPMENT MODE
# whenever --update-crontab CITS3403_todo_list --set environment=development