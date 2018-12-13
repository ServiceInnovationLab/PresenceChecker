# frozen_string_literal: true

namespace :clients do
  desc 'Subscribe to incoming sensor messages'

  task calculate: :environment do
    (0..366).each do |n|
      day = (Date.today + n).strftime('%Y-%m-%d')
      Client.all.order(:id).each do |client|
        next if Eligibility.where(client: client, day: day).size.positive?

        puts "Calculating client #{client.id} #{day}"
        EligibilityService.new(client, day).run!
        puts
      end
    end
  end
end
