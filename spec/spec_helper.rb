require 'spec'
require 'rubygems'
require 'ruby-debug'
require 'activerecord'

##################
#### <CUSTOM> ####
##################
# Aliased "lambda" with "doing" so that when checking
# whether or not something raises an exception it will
# read like other rspec operations.  For example:
# instead of
# lambda { ... }.should_not raise_error
# you can have
# doing { ... }.should_not raise_error
alias :doing :lambda
###################
#### </CUSTOM> ####
###################

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
ActiveRecord::Base.configurations = true

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define(:version => 1) do
  create_table :clients do |t|
    t.string :first_name
    t.string :last_name
  end
  
  create_table :addresses do |t|
    t.string :address1
    t.string :address2
    t.string :city
    t.string :state
    t.string :postal_code
  end
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'pdf_filler'


module GBDev
  module TestData
    module Addresses
      def create_corpus!
        create!(:address1 => '111 AAA St', :address2 => 'Suite 444', :city => 'Reno',    :state => 'Nevada', :postal_code => '89506')
        create!(:address1 => '222 BBB St', :address2 => 'Suite 555', :city => 'Sparks',  :state => 'Nevada', :postal_code => '89434')
        create!(:address1 => '333 CCC St', :address2 => 'Suite 666', :city => 'Fernley', :state => 'Nevada', :postal_code => '89408')
      end
    end
  end
end


Spec::Runner.configure do |config|
  config.before(:each) do
    class Client < ActiveRecord::Base
      acts_as_pdf_db_mapper :only => [:first_name, :last_name]
      has_many :addresses, :dependent => :destroy
      
      def full_name
        [self.first_name, self.last_name].join(' ')
      end
    end
    
    class Address < ActiveRecord::Base
      acts_as_pdf_db_mapper
      belongs_to :client      
      extend GBDev::TestData::Addresses
    end
    
    class ClientAddress < ActiveRecord::Base
      set_table_name :addresses
      acts_as_pdf_db_mapper :only => [:state, :city]
    end

    class ContactAddress < ActiveRecord::Base
      set_table_name :addresses
      acts_as_pdf_db_mapper :except => [:id, :address1, :postal_code]
    end

    class UserAddress < ActiveRecord::Base
      set_table_name :addresses
      acts_as_pdf_db_mapper :include => [{:full_address => :address}]
      
      def full_address
        [self.address1, self.address2].join(', ')
      end
    end    
    
    class FamilyAddress < ActiveRecord::Base
      set_table_name :addresses
      acts_as_pdf_db_mapper :only_include => [{:full_address => :address}]
      
      def full_address
        [self.address1, self.address2].join(', ')
      end
    end    
    
    Client.destroy_all
    Address.destroy_all
  end
  
  config.after(:each) do
    Object.send(:remove_const, :Client)
    Object.send(:remove_const, :Address)
  end
end
