# frozen_string_literal: true

require "rails_helper"

module Test
  class ExampleTemplate < Notifications::Emails::Templates::Base
    attr_accessor :first_name, :last_name

    def required_fields
      %i[first_name last_name]
    end

    def name
      "template_name"
    end

    def subject
      "Email subject"
    end

    def global_merge_vars
      [
        {name: :first_name, content: first_name},
        {name: :last_name, content: last_name}
      ]
    end
  end
end

RSpec.describe Notifications::Emails::Templates::Base do
  let(:example_template) { Test::ExampleTemplate.new }

  specify "#to_json" do
    expect(example_template.method(:to_json).arity).to eq(0)
  end

  context "when all required fields are populated" do
    it "is valid" do
      example_template.first_name = "123"
      example_template.last_name = "123"

      expect(example_template).to be_valid
    end
  end

  context "when all required fields are not populated" do
    it "is not valid" do
      example_template.first_name = "123"
      example_template.last_name = nil

      expect(example_template).not_to be_valid
    end
  end
end
