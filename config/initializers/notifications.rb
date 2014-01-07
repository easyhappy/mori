ActiveSupport::Notifications.subscribe "process_action.action_controller"do |name, start, finish, id, payload|
  total_cost = (finish - start) * 1000
  max_cost = 0
  if total_cost > max_cost
    VisitedPageMongo.create do |page_request|
      page_request.path         = payload[:path]
      page_request.total_cost   = total_cost
      page_request.view_cost    = payload[:view_runtime]
      page_request.db_cost      = payload[:db_runtime]
      page_request.host_name     = `hostname`.strip
    end
  end
end
