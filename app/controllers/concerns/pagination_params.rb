module PaginationParams
  extend ActiveSupport::Concern
  PAGE_SIZE = 10
  PAGE_NUMBER = 1

  def pagination_params
    params.dig(:page)&.slice(
      :size,
      :number
    ) || {}
  end

  def page_size
    pagination_params[:size] || PAGE_SIZE
  end

  def page_number
    pagination_params[:number] || PAGE_NUMBER
  end
end