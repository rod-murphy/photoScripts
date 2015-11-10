#!/usr/bin/env ruby

require "rubygems"
require "dbox"
require "dotenv"

Dotenv.load(
  ".env.dbox.local"
)

LOGFILE = "/home/rod/dbox.log"
LOCAL_PATH = "/media/usbDriveA/Photos"
REMOTE_PATH = "/Photos"
INTERVAL = 60 # time between syncs, in seconds

LOGGER = Logger.new(LOGFILE, 1, 1024000)
#LOGGER.level = Logger::INFO
LOGGER.level = Logger::DEBUG

def main
  while 1
    begin
      sync
    rescue Interrupt => e
      exit 0
    rescue Exception => e
      LOGGER.error e
    end
    sleep INTERVAL
  end
end

def sync
  unless Dbox.exists?(LOCAL_PATH)
    LOGGER.info "Cloning"
    Dbox.clone(REMOTE_PATH, LOCAL_PATH)
    LOGGER.info "Done"
  else
    LOGGER.info "Syncing"
    Dbox.push(LOCAL_PATH)
    Dbox.pull(LOCAL_PATH)
    LOGGER.info "Done"
  end
end

main
