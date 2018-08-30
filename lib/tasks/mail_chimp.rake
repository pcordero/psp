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
    params =  {"utf8"=>"✓", "authenticity_token"=>"QEJ4OsilHM09UCREob3ta34HuXUeSYtvhrYbv41f+xA=", "subscription"=>{:name=>"Scott Johnson", :email=>"fuzzygroup+test1@gmail.com", :cycle=>"daily", :state_code=>"ut"}, "commit"=>"Subscribe", :state_id=>"ut"}
    
    @subscription = Subscription.new(params["subscription"])
    if @subscription.save
    else
      raise @subscription.errors.full_messages.inspect
    end
  end
  
  task :list_segments => :environment do
    gibbon = Gibbon::Request.new(api_key: MC_API_KEY, symbolize_keys: true)
    puts gibbon.lists(660481).segments.retrieve
  end
  
  # bundle exec rake mail_chimp:create_new_lists
  task :create_new_lists => :environment do
    @states = %w{al ak az ar ca co ct de fl ga hi id il in ia ks ky la me md ma mi mn ms mo mt ne nv nh nj nm ny nc nd oh ok or pa ri sc sd tn tx ut vt va wa wv wi wy}
    gibbon = Gibbon::Request.new(api_key: MC_API_KEY, symbolize_keys: true)
    
    params = {
        "name" => "mail-list-psp-#{@states.first}",
        "contact" => {
            "company" => "Public Servants Prayer",
            "address1" => "",
            "address2" => "",
            "city" => "",
            "state" => "",
            "zip" => "",
            "country" => "",
            "phone" => ""
        },
        "permission_reminder" => "You are receiving this email, because you subscribed to our product.",
        "campaign_defaults" => {
            "from_name" => "Matthew Barnes",
            "from_email" => "matthew@publicservantsprayer.org",
            "subject" => "Public Servants' Prayer",
            "language" => "en"
        },
        "email_type_option" => true,
        "merge_fields" => {
          "Email": {name: "EMAIL", type: "text"},
          "Name": {name: "NAME", type: "text"},
          "Subscribed": {name: "MMERGE2", type: "text"},
          "Status": {name: "MMERGE3", type: "text"},
          "First Name": {name: "FNAME", type: "text"},
          "Last Name": {name: "LNAME", type: "text"},
          "Prayer list frequency": {name: "RADIOYUI_", type: "text"},
          "Choose your state": {name: "SELECTYUI", type: "text"}
        }
    }
    tmp = {
      "Email": {name: "EMAIL", type: "text"},
      "Name": {name: "NAME", type: "text"},
      "Subscribed": {name: "MMERGE2", type: "text"},
      "Status": {name: "MMERGE3", type: "text"},
      "First Name": {name: "FNAME", type: "text"},
      "Last Name": {name: "LNAME", type: "text"},
      "Prayer list frequency": {name: "RADIOYUI_", type: "text"},
      "Choose your state": {name: "SELECTYUI", type: "text"}
    }
    
    mail_chimp_list = gibbon.lists.create(body: params)
    debugger
    mail_chimp_list.merge_fields.create(tmp)
    #g.lists(mylistid).merge_fields.create(body: {name: "myvar", type: "text"})
    
    @states.each do |state|

    end
  end
  
  # bundle exec rake mail_chimp:create_sub --trace
  task :create_sub => :environment do
    params = {"utf8"=>"✓", "authenticity_token"=>"X0TWTkCMiTL90SwsLJmj37PEcB8X2kdEdGU33Hu/03w=", "subscription"=>{"name"=>"Scott Johnson", "email"=>"fuzzygroup+3245@gmail.com", "cycle"=>"weekly", "state_code"=>"wa"}, "commit"=>"Subscribe", "action"=>"create", "controller"=>"subscriptions", "state_id"=>"wa"}
    params = {"utf8"=>"✓", "authenticity_token"=>"X0TWTkCMiTL90SwsLJmj37PEcB8X2kdEdGU33Hu/03w=", "subscription"=>{"name"=>"Scott Johnson", "email"=>"fuzzygroup+3245@gmail.com", "cycle"=>"weekly", "state_code"=>"wa"}, "commit"=>"Subscribe", "action"=>"create", "controller"=>"subscriptions", "state_id"=>"ny"}
        @state = UsState.new(params["state_id"])
    @subscription = Subscription.new(params["subscription"])
    if @subscription.save
    else
      @subscription
    end
    debugger
  end
  
end
