class User < ActiveRecord::Base
    has_many :queries
    has_many :foods, through: :queries
end