class ApplicationController < ActionController::Base
  before_action :block_foreign_hosts
  protect_from_forgery with: :exception
end

def block_foreign_hosts
  whitelist_prefix = ENV['whitelist_prefix'].split(',')
  
  logger.info(whitelist_prefix + " remote_ip: " + request.remote_ip)
  whitelist_prefix.each do |item|
    return false if request.remote_ip.start_with?(item)
  end
  raise ActionController::RoutingError.new('Not Found')
end
