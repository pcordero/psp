namespace :mail_chimp do

  # bundle exec rake mail_chimp:set_up_segments --trace
  task :set_up_segments => :environment do
    UsState.new.names.each do |code, name|
      state = UsState.new(code)
      MailListSegment.new(state, 'daily').create
      MailListSegment.new(state, 'weekly').create
    end
  end
  
  # bundle exec rake mail_chimp:test_single_signup --trace
  task :test_single_signup => :environment do
    params =  {"utf8"=>"✓", "authenticity_token"=>"QEJ4OsilHM09UCREob3ta34HuXUeSYtvhrYbv41f+xA=", "subscription"=>{:name=>"Scott Johnson", :email=>"fuzzygroup@gmail.com", :cycle=>"daily", :state_code=>"ut"}, "commit"=>"Subscribe", :state_id=>"ut"}
    
    @subscription = Subscription.new(params["subscription"])
    if @subscription.save
    else
      raise @subscription.errors.full_messages.inspect
    end
  end
end
