namespace :daily_tweet do
  desc "Tweet to all the states"
  task :tweet => :environment do
    us_states  = {
      AL: "Alabama", AK: "Alaska", AZ: "Arizona",
      AR: "Arkansas", CA: "California", CO: "Colorado", CT: "Connecticut",
      DE: "Delaware", FL: "Florida", GA: "Georgia",
      HI: "Hawaii", ID: "Idaho", IL: "Illinois", IN: "Indiana", IA: "Iowa",
      KS: "Kansas", KY: "Kentucky", LA: "Louisiana", ME: "Maine", MD: "Maryland",
      MA: "Massachusetts", MI: "Michigan", MN: "Minnesota", MS: "Mississippi",
      MO: "Missouri", MT: "Montana", NE: "Nebraska", NV: "Nevada",
      NH: "New Hampshire", NJ: "New Jersey", NM: "New Mexico", NY: "New York",
      NC: "North Carolina", ND: "North Dakota", OH: "Ohio", OK: "Oklahoma",
      OR: "Oregon", PA: "Pennsylvania", RI: "Rhode Island",
      SC: "South Carolina", SD: "South Dakota", TN: "Tennessee", TX: "Texas",
      UT: "Utah", VT: "Vermont", VA: "Virginia", WA: "Washington",
      WV: "West Virginia", WI: "Wisconsin", WY: "Wyoming"
    }

    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_API_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_API_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    us_states.each do |state|
      Rails.logger.info "Processing #{state}"
      puts "Processing #{state}"
      begin
        state = UsState.new(state[0].to_s)

        leaders = LeaderSelector.for_day(state, Date.today)

        tweet = [
          "@praying4_#{state[0].to_s} please pray for ",
            leaders.map { |l| "#{l.title} #{l.name}" }
          ].flatten.join("\n");

        r = twitter.update(tweet)
      rescue StandardError => e
        puts "Error when tweeting to #{state[0]}: #{e.message}"
      end
    end
  end

end
