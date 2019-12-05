class Query < ActiveRecord::Base
    belongs_to :user
    belongs_to :food
    validates :user, uniqueness: {scope: :food}
end