module ApiHelper
  def json_body
    ActiveSupport::JSON.decode(response.body)
  end

  def json_body_data
    json_body['data']
  end

  def json_body_attributes
    json_body['data']['attributes']
  end
end
