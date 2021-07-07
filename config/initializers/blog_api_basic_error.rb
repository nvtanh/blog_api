class BlogApiBasicError < StandardError
  attr_reader :msg, :http_status

  def initialize(msg, http_status = nil)
    super(msg)
    @http_status = http_status
  end
end