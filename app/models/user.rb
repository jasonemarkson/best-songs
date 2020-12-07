class User < ActiveRecord::Base
    has_many :songs
    validates_presence_of :username, :password
end