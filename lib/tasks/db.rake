namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Creating Role"
    Fabricate :role, name: "admin"
    Fabricate :role, name: "trainer"
    Fabricate :role, name: "trainee"
    3.times do
      Fabricate :role
    end

    puts "Creating User"
    Fabricate :user, email: "admin@tms.com", role_id: 1
    Fabricate :user, email: "supervisor@tms.com", role_id: 2
    30.times do
      Fabricate :user
    end

    puts "Creating Subject"
    10.times do
      Fabricate :subject
    end

    puts "Creating Evaluation Template"
    5.times do
      Fabricate :evaluation_template
    end

    puts "Creating Task Master"
    5.times do
      Fabricate :task_master
    end
  end
end
