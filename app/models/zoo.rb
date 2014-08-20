class Zoo < ActiveRecord::Base
	belongs_to :zookeeper, class_name: "User", foreign_key: :zookeeper_id
	has_many :animals

end
