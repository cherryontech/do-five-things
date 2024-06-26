class InertiaExampleController < ApplicationController
  def index
    Counter.create do |counter|
      counter.click = 1
    end if Counter.find_by_id(1).nil?

    render inertia: "InertiaExample", props: {
      name: params.fetch(:name, "Planet"),
      count: Counter.last.click
    }
  end

  def increase_counter
    puts params
    counter = Counter.find(1)
    counter.click = params["count"].to_int
    counter.save!

    render inertia: "InertiaExample", props: {
      name: params.fetch(:name, "howdy"),
      count:  89
    }
  rescue StandardError => e
    Rails.logger.info e
  end
end
