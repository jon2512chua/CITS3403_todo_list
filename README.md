#CITS3403 todo list

## Whenever Scheduler
- Now able to schedule sending of email reminders 
  - First: run `whenever --update-crontab CITS3403_todo_list --set environment=development` in terminal
  - Update your gmail account details in `config/environments/development.rb` lines 30 & 31
    - This would schedule emails to be sent every minute as specified in `config/schedule.rb`
      - (I chose it to be done this way for the moment for testing purposes. Server time and system time are highly incongruent.)

- *Stopping Scheduler*: run `whenever --update-crontab CITS3403_todo_list --set environment=production` in terminal

##Things we still have to do
- Be able to edit items
  - ~~Todo items~~
- Send reminders
  - Add due date to the item model (value can be null)
  - Write function that sends email if item is less than one day till due date
  - Use cron or some other scheduling system to call that function every day/hour (probably better if we use day since we're only using date and not datetime and we won't take into account different timezones)
- Make sure there are tests for everything if possible...
- Make everything pretty @"@
  - Create item form
  - Have seperate all, completed and uncompleted blocks
  - Fix up typography, spacing between text
- Finish the help, about us, profile pages
- Write the deliverables

Use 2 space indentation for EVERYTHING. ruby, html, js, everything.

### Yes there is a lot that we have to get through!

### By thursday we HAVE to be finished, it must work on the uni computers. No last minute friday panic please. :]

## CSSE Linux Server
- cits3403.csse.uwa.edu.au
- ~~add therubyracer gem~~
- symbolic link to proj/public (ln -s proj/public public_html/proj
