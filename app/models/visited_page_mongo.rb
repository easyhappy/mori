class VisitedPageMongo
  include Mongoid::Document
  field :path
  field :total_cost
  field :view_cost
  field :db_cost
  field :host_name
end
