require 'spec_helper'
require 'active_record'
require 'napa_rabbit_publisher'
require 'napa'

describe NapaRabbitPublisher::RabbitActiveRecordCallbacks do
  class Foo < ActiveRecord::Base
    include NapaRabbitPublisher::RabbitActiveRecordCallbacks
  end

  class Bar < ActiveRecord::Base
    include NapaRabbitPublisher::RabbitActiveRecordCallbacks
  end

  class BarRepresenter < Napa::Representer
    property :id, type: String
    property :name
  end

  ENV['SERVICE_NAME'] = 'test'

  context 'when included in an AR model' do
    context 'when creating a record' do
      it 'broadcasts a message' do
        expect_any_instance_of(Bunny::Exchange).to receive(:publish)
        f = Foo.create()
      end

      it 'uses the amqp_properties method if found' do
        expect_any_instance_of(Foo).to receive(:amqp_properties)
        f = Foo.create()
      end

    end
    context 'when updating a record' do
      it 'broadcasts a message' do
        f = Foo.create()
        expect_any_instance_of(Bunny::Exchange).to receive(:publish)
        f.update_attributes(word: :bar)
      end
    end
    context 'when it has a representer' do
      it 'broadcasts a message with the representer' do
        expect_any_instance_of(Bunny::Exchange).to receive(:publish) do |method, data, options|
          obj = JSON.parse(data)
          expect(obj['id']).to be_a String
          expect(obj['name']).to eq 'baz'
        end
        b = Bar.create(name: 'baz')
      end
    end
  end
end
