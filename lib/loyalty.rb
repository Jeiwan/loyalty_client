require 'savon'
require 'nori'
require 'gyoku'
require 'securerandom'
require 'logger'

module Loyalty
end

require 'loyalty/account_service.rb'
require 'loyalty/loyalty_service/operations.rb'
require 'loyalty/loyalty_service.rb'
require 'loyalty/data/cheque.rb'
require 'loyalty/data/cheque_item.rb'
require 'loyalty/data/rollback_cheque.rb'
require 'loyalty/data/sale_cheque.rb'
require 'loyalty/data/sale_cheque_item.rb'
require 'loyalty/exceptions/request_error.rb'
