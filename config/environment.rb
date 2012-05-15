# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
GrampianSpiderGroup::Application.initialize!

require 'will_paginate'

config.action_mailer.delivery_method = :smtp

config.actionMailer.raise_delivery_errors = true