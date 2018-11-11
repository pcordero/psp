UsState.names.each do |code, name|
  state = UsState.new(code)
  leaders = LeaderSelector.for_day(state, Date.today)
  pray_for = leaders.map{|x| x.twitter_or_name}.join(", ")
  system("twurl set default paying4_#{code};twurl -d \"status=Please pray today for #{pray_for}\" /1.1/statuses/update.json")
end
