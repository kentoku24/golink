class ApplicationController < ActionController::Base
  before_action :block_foreign_hosts
  protect_from_forgery with: :exception
end

def block_foreign_hosts
  logger.info("whitelist: " + ENV['WHITELIST'])
  whitelist_prefix = ENV['WHITELIST'].split(',')
  
  logger.info("whitelist: %s remote_ip: %s" % [whitelist_prefix, request.remote_ip])
  return false if whitelist_prefix.include? '*'
  whitelist_prefix.each do |item|
    return false if request.remote_ip.start_with?(item)
  end
  raise ActionController::RoutingError.new('Not Found')
end
