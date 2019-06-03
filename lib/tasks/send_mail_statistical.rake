require "rake"
namespace :task_namespace do
  desc "task description"
  task send_mail: :environment do
    User.send_mail_statistical
  end
end
