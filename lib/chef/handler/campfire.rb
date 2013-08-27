#!/usr/bin/env ruby
# Chef Exception & Reporting Handler for Campfire.
#
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Author:: Brian Scott <mailto:brainscott@gmail.com>
# Author:: Matt Reiferson <mailto:mreiferson@gmail.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#

require 'rubygems'
require 'chef/handler'
require 'broach'

class Chef
  class Handler
    class Campfire < Chef::Handler
      VERSION = '2.0.3'
      
      def initialize(subdomain, token, room)
        @subdomain = subdomain
        @token = token
        @room = room
      end
      
      def report
        Broach.settings = {'account' => @subdomain, 'token' => @token, 'use_ssl' => true}
        room = Broach::Room.find_by_name(@room)
        
        if run_status.failed?
          Chef::Log.error('delivering exception to campfire')
          
          room.speak("#{node.name}: Chef Exception")
          exception = [run_status.formatted_exception] + Array(backtrace)
          room.paste(exception.join("\n"))
        else
          Chef::Log.info('delivery report to campfire')
          
          room.speak("#{node.name}: Chef Report")
          resources = ["Updated #{run_status.updated_resources.length} resource(s):"]
          run_status.updated_resources.each do |res|
            resources << "    #{res.resource_name}[#{res.name}]"
          end
          room.paste(resources.join("\n"))
        end
        
        room.speak("start #{run_status.start_time} end #{run_status.end_time} in #{run_status.elapsed_time}s")
      end
    end
  end
end
