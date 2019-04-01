class NewsletterSubscriber < ServiceBase

  def call
    process
  end

  private

    attr_reader :email, :segment, :options

    def initialize(email, segment, options)
      @email = email
      @segment = segments
      @options = options
    end

    def process
      
    end
end
