class ServiceBase
  def self.call(*args)
    self.new(*args).call
  end
end

class ServiceResponse
  attr_reader :data, :message

  def initialize(data, message)
    @data = data
    @message = message
  end

  def success?
    raise NotImplementedError
  end
end

class ServiceSuccess < ServiceResponse
  def success?
    true
  end
end

class ServiceError < ServiceResponse
  def success?
    false
  end
end
