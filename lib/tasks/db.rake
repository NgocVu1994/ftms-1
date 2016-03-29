namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    Rake::Task["db:migrate:reset"].invoke

    puts "Creating Role"
    ["admin", "trainer"].each do |name|
      Fabricate :role, name: name, allow_access_admin: true
    end
    Fabricate :role, name: "trainee", allow_access_admin: false

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

    puts "Creating Permissions"
    Fabricate :permission, model_class: "CourseMaster", role_id: 1
    ["Course", "CourseSubject", "Subject", "UserSubject"].each do |name|
      Fabricate :permission, model_class: name, action: "manage", role_id: 2
    end
    ["update", "show"].each do |name|
      Fabricate :permission, model_class: "UserSubject", action: name
      Fabricate :permission, model_class: "UserTask", action: name
      Fabricate :permission, model_class: "User", action: name
    end

    puts "Create Rank"
    5.times do
      Fabricate :rank
    end

    puts "Create Universities"
    Fabricate :university, name: "Vietnam National University, Hanoi"
    Fabricate :university, name: "Hanoi University of Science and Technology"
    Fabricate :university, name: "Foreign Trade University"
    Fabricate :university, name: "Hanoi University of Industry"

    puts "Create Programming Languages"
    Fabricate :programming_language, name: "Ruby"
    Fabricate :programming_language, name: "PHP"
    Fabricate :programming_language, name: "Android"
    Fabricate :programming_language, name: "Java"
    Fabricate :programming_language, name: "C"

    puts "Create Types"
    Fabricate :type, name: "Intern"
    Fabricate :type, name: "VPG"
    Fabricate :type, name: "JPG"
    Fabricate :type, name: "New dev"
    Fabricate :type, name: "Tester"

    puts "Create Progress"
    Fabricate :progress, name: "Tutorial"
    Fabricate :progress, name: "Project demo"
    Fabricate :progress, name: "Project 1"
    Fabricate :progress, name: "Project 2"
    Fabricate :progress, name: "Git"

    puts "Create Status"
    Fabricate :status, name: "Inprogress"
    Fabricate :status, name: "Finish"
    Fabricate :status, name: "Prepare project"
    Fabricate :status, name: "Jointed project"

  end
end
