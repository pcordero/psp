class Subscription
  include ActiveModel::Validations

  validates_presence_of :email
  validates_format_of :email, :with => URI::MailTo::EMAIL_REGEXP

  attr_accessor :email, :name, :address, :city, :state, :zipcode, :state_code, :cycle, :state_id, :first_name, :last_name, :full_name

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def full_name
    first_name ? "#{first_name} #{last_name}" : name
  end

  def mail_chimp
    @mail_chimp ||= MailChimp.new
  end

  def us_state
    @us_state ||= UsState.new(state_code)
  end

  def segment
    @segment ||= MailListSegment.new(us_state, cycle)
  end

  def save
    if valid?
      #debugger
      mail_chimp.subscribe_to_segment(email, segment, merge_vars)
    else
      false
    end
  end

  def merge_vars
    {
      name: full_name,
      address: address,
      city: city,
      state: state_code,
      zipcode: zipcode,
      cycle: cycle,
      state_code: state_code

    }
  end

  def to_model
    self
  end

  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

  def new_record?() true end
  def destroyed?()  true end
  def persisted?()  false end
end
