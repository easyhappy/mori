# Use this file to easily define all of your cron jobs.i
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "/home/andy/Documents/mori/log/cron_log.log"
set :environment, "development"

every 1.minutes do
  command "sh /home/andy/Documents/mori/config/pskill.sh"
end