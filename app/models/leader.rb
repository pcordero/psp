class Leader < Hashie::Mash
  disable_warnings

  def setup(data)
    data.each do |key, value|
      self[key] = value
    end
  end

  def state
    UsState.new(state_code)
  end

  def birthday
    unless born_on.blank?
      Date.parse(born_on).strftime("%B %e")
    else
      ""
    end
  end

  def district_residence
    [district, residence].reject{|i|i.blank?}.join(" - ")
  end

  def name
    [first_name, mid_name, last_name].reject{|i|i.blank?}.join(" ") || ""
    #self['name'] || ""
  end

  def title
    self['title'] || ""
  end

  def email
    self['email'] || ""
  end

  # photo_file="Steube_WGreg_289471.jpg" photo_path="Images\\Photos\\SL\\FL\\H"
  def photo_src
    #return self['photo_src'] || "http://placehold.it/109x148"
    #return self['photo_src'] || "placeholder.png"
    ps = "#{self['photo_path'].sub(/Images\/\//,'public/')}#{self['photo_file']}"
    #self['photo_src'] || "placeholder.jpg"
    if self['photo_file']
      return ps
    else
      return "http://placehold.it/109x148" #"placeholder.jpg"
    end
  end

  def twitter_or_name
    return name if twitter.blank?
    twitter_handle
  end

  private

  def twitter_handle
    "@#{twitter.split('/').last}"
  end
end

