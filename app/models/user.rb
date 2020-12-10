class User < ActiveRecord::Base
    has_secure_password

    has_many :songs
    validates_presence_of :username, :password
end