module V1
  module Dashboard
    class BaseController < ApplicationController
      include AuthClient

      before_action :authenticate
    end
  end
end
