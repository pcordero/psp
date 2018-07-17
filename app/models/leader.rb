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
    return "http://placehold.it/109x148" if self['photo_file'].nil?
    return "http://placehold.it/109x148" if self['photo_path'].nil? 
    
    # works: http://18.191.175.149/photos/SL/AK/H/Birch_Chris_583178.jpg
    
    # @leader.photo_path
    # => "Images\\Photos\\FL\\H"
    #Rails.logger("self.photo_path = #{self.photo_path}")
      
    #Rails.logger("p_path = #{p_path}")
    
    p_path = self.photo_path.sub(/Images/,'').sub(/Photos/,'photos').gsub(/\\/,'/')
    
    parts = self["photo_file"].split("_")
    
    arr = []
    arr << parts[parts.size - 3]
    arr << parts[parts.size - 2]
    
    file_by_number = File.join(Rails.root, "public", arr.join("_"))
    
    #return self['photo_src'] || "http://placehold.it/109x148"
    #return self['photo_src'] || "placeholder.png"
    #ps = "#{self['photo_path'].sub(/Images\/\//,'public/')}#{self['photo_file']}"
    ps = "#{p_path}/#{photo_file}"
    #self['photo_src'] || "placeholder.jpg"
    if self['photo_file']
      tmp = File.join(Rails.root, "public/Photos/", self['photo_file'])
      # <img alt="Biggert_judy_158840" class="head-shot" src="/assets/\photos\FL\H/Biggert_Judy_158840.jpg">
      if 1 == 1 || File.exists?(tmp)
        return ps 
      elsif File.exists?(file_by_number)
        return file_by_number
      else
        return "http://placehold.it/109x148" 
      end
      
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

