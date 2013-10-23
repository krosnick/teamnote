class Note < ActiveRecord::Base

    validates_presence_of :title

    has_many :authorizations
    has_many :users, through: :authorizations
end
