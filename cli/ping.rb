def full_path( file_name )
  File.expand_path( File.join File.dirname( $0 ), file_name )
end

ENV['BUNDLE_GEMFILE'] = full_path '../Gemfile'
require 'bundler/setup'

class Ping
  require 'net/ping'

  def self.ping( ip_address, port )
    pinger = Net::Ping::TCP.new ip_address, port, 2
    pinger.ping?
  end
end

p Ping.ping( ARGV[0], ARGV[1].to_i )
