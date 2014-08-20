class User < ActiveRecord::Base
	has_many :zoos, foreign_key: :zookeeper_id
	has_many :animals, through: :zoos

	validates :email, presence: true, uniqueness: true
	has_secure_password
end
