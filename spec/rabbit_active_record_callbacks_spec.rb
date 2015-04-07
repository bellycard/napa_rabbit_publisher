require 'spec_helper'
require 'active_record'
require 'napa_rabbit_publisher'

describe NapaRabbitPublisher::RabbitActiveRecordCallbacks do
  class Foo < ActiveRecord::Base
    include NapaRabbitPublisher::RabbitActiveRecordCallbacks
  end
  ENV['SERVICE_NAME'] = 'test'

  context "when included in an AR model" do
    context "when creating a record" do
      it "broadcasts a message" do
        expect_any_instance_of(Bunny::Exchange).to receive(:publish)
        Foo.create
      end

      it "uses the amqp_properties method if found" do
        expect_any_instance_of(Foo).to receive(:amqp_properties)
        Foo.create
      end

    end

    context "when updating a record" do
      it "broadcasts a message" do
        f = Foo.create
        expect_any_instance_of(Bunny::Exchange).to receive(:publish)
        f.update_attributes(word: :bar)
      end
    end

    context "when deleting a record" do
      it "broadcasts a message" do
        f = Foo.create
        expect_any_instance_of(Bunny::Exchange).to receive(:publish)
        f.destroy
      end
    end
  end
end
